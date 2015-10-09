class DebtBalance < ActiveRecord::Base
  include DateModule

  belongs_to :debt

  validates_presence_of :debt_id, :due_date, :balance
  validates :balance, numericality: true

  validates_uniqueness_of :debt_id, :scope => :due_date, message: "balance already due on this date"
  #validate :budget_not_set_for_month
  validate :start_pay_date

  before_validation do 
    self.payment_start_date = self.due_date - 1.months + 1.days if !self.due_date.blank? && self.payment_start_date.blank?
  end

  def payments
    Spending.joins(:category)
            .where("spendings.description = '#{self.debt.name}' AND categories.name = '#{self.debt.category}'")
            .where("spending_date>='#{self.payment_start_date}' AND spending_date<='#{self.due_date}'")
  end

  def balance_of_interest
    #current_balance = self.debt.is_asset? ? self.target_balance - self.balance : self.balance - self.target_balance
    current_balance = ( self.target_balance - self.balance ).abs
  end

  def payment_due
    self.debt.pay_from == 'Chase' ? chase_payment_due : boa_payment_due
  end

  def payments_to_date
    self.debt.pay_from == 'Chase' ? chase_fridays(self.payment_start_date, Time.now.to_date) : boa_fridays(self.payment_start_date, Time.now.to_date)
  end

  def chase_payment_due
    self.balance_of_interest/chase_fridays(self.payment_start_date, self.due_date)
  end

  def boa_payment_due
    self.balance_of_interest/boa_fridays(self.payment_start_date, self.due_date)
  end

  def close
    if self.debt.is_asset?
      new_target_balance = self.balance + ( payment_due * payments_to_date )
    else
      new_target_balance = self.balance - ( payment_due * payments_to_date )
    end
    
    update_attribute(:target_balance, new_target_balance)    
    update_attribute(:due_date, Time.now.to_date)
  end

  private
  def budget_not_set_for_month
    errors.add(:debt, "balance already set for #{self.due_date.strftime('%B %Y')}") if DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND DATE_FORMAT(due_date, '%Y-%m-%01') = DATE_FORMAT('#{self.due_date}', '%Y-%m-%01')").exists? 
  end

  def start_pay_date
    if DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.payment_start_date}' <= due_date AND '#{self.due_date}' > due_date").exists?
      previous = DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.payment_start_date}' <= due_date AND '#{self.due_date}' > due_date").order(due_date:  "desc").first
      errors.add(:payment_start_date, "must be after #{previous.due_date}.")
    end

    if DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.payment_start_date}' >= payment_start_date AND '#{self.payment_start_date}' <= due_date").exists?
      goal = DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.payment_start_date}' >= payment_start_date AND '#{self.payment_start_date}' <= due_date").order(due_date:  "desc").first
      errors.add(:goal, "already set between #{goal.payment_start_date} and #{goal.due_date}")
    end

    if DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.due_date}' >= payment_start_date AND '#{self.due_date}' <= due_date").exists?
      goal = DebtBalance.where("id != #{self.id || 0} AND debt_id = #{self.debt_id} AND '#{self.due_date}' >= payment_start_date AND '#{self.due_date}' <= due_date").order(due_date:  "desc").first
      errors.add(:goal, "already set between #{goal.payment_start_date} and #{goal.due_date}")
    end
    
    if !self.due_date.blank? && !self.payment_start_date.blank?
      if self.due_date < self.payment_start_date
        errors.add(:payment_start_date, "(#{self.payment_start_date}) must be before due date (#{self.due_date})")
      end
    end
  end

end
