module Recommender
  def debts
    DebtBalance.includes(:debt).search_by_date(balance_date)
  end

  def make_payments
    success = true
    recommendations.each do |k, v|
      next if Debt.do_not_pay_list.include? k
      new_debt = Debt.find_by(name: k, deleted_at: nil)
      next if new_debt.nil?
      db = debts.find_by(debt_id: new_debt.id)
      budget = db.debt.category.budgets.find_by(budget_month: balance_date.change(day: 1))
      pm = db.debt.account.payment_method
      if db && budget && pm
        Spending.create(amount: v[1], description: db.debt.name, spending_date: balance_date, budget: budget, payment_method: pm, debt_balance: db) unless v[1] == 0
      else
        success = false
      end
    end
    update(paid: true)
    success
  end

  def undo_payments
    payments = Spending.where(spending_date: balance_date).where.not(debt_balance_id: nil)
    payments.each(&:destroy)
    update(paid: false)
  end

  def main_account_payment
    result = 0
    other = AccountBalance.search_by_date(balance_date).where("id != #{id || 0}")
    if other.exists?
      rec = other.first.recommendations(false)[debt_balance.debt.name]
      result = rec[1] unless rec.nil?
    end
    result
  end

  def recommendations(check_main_account = true)
    result = {}
    left_over = account.name # default to checking
    left_over = debt_balance.debt.name if debt_balance # focus
    left_over_amount = amount # checking amount

    result[account.name] = [amount, buffer, amount]
    left_over_amount -= buffer

    debts.select { |db| db.debt.account == account || db == debt_balance }.map do |d|
      max_amount = [d.max_payment(balance_date, true), 0].max
      if d.debt.account != account && check_main_account
        max_amount -= main_account_payment
      end
      recommendation = [d.payment_due(balance_date, true), 0].max
      recommendation = [recommendation, max_amount].min # do not recommend more than the max
      actual = [max_amount, recommendation].min
      actual = max_amount if max_amount <= 25
      result[d.debt.name] = [recommendation, actual, max_amount]
      left_over_amount -= actual unless d.debt.name == left_over
    end

    unless result[left_over].nil?
      if left_over == account.name
        result[left_over][1] += left_over_amount
      else
        result[left_over][1] = [left_over_amount, result[left_over][2]].min
        result[account.name][1] += (left_over_amount - result[left_over][1]) # add diff between leftover and max payment allowed
      end
    end

    total = 0
    result.map { |_k, v| total += v[1].abs }
    self.total_distribution = total
    result
  end
end
