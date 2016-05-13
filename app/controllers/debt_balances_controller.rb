class DebtBalancesController < ApplicationController
  include SpendingsHelper
  include DateModule

  before_action :admin_only
  before_action :set_debt_balance, only: [:show, :edit, :update, :destroy, :close]

  # GET /debt_balances
  # GET /debt_balances.json
  def index
    @debt_balances = current_user.get_all('debt_balances').search(params[:debt_balance]).order(due_date: :desc).paginate(per_page: 25, page: params[:page])
    @debts = current_user.get_all('debt_balances').joins(debt: :category).where("debt_balances.payment_start_date <= '#{Time.now.to_date}' AND '#{Time.now.to_date}' <= due_date AND debts.is_asset=false AND categories.name NOT IN ('Rent','Donation/Gift (Recurring)')")

    @last_3_months = {}
    last_n_months(3).reverse_each do |date|
      end_date = [date[1].end_of_month, Time.now.to_date].min
      total_debt = 0
      current_user.get_all('debt_balances').joins(debt: :category).where("debt_balances.payment_start_date <= '#{end_date}' AND '#{end_date}' <= due_date AND debts.is_asset=false AND categories.name NOT IN ('Rent','Donation/Gift (Recurring)')").each { |k| total_debt += k.max_payment(end_date, true) }
      @last_3_months.store(date[0], total_debt)
    end
    @last_3_months = @last_3_months.to_a
  end

  def ccs_by_month
    render json: current_user.get_all('debt_balances').joins(debt: :category)
      .where('categories.cc_payment = ?', true)
      .group('debts.name')
      .group_by_month(:due_date, format: '%b %Y')
      .having('sum(debt_balances.balance) > ?', 0)
      .sum(:balance)
      .chart_json
  end

  def loans_by_month
    h1 = {}

    last_n_months(12).reverse_each do |date|
      end_date = [date[1].end_of_month, Time.now.to_date].min
      total_debt = 0
      current_user.get_all('debt_balances').joins(debt: :category).where("debt_balances.payment_start_date <= '#{end_date}' AND '#{end_date}' <= due_date AND debts.is_asset=false AND categories.name NOT IN ('Rent','Donation/Gift (Recurring)')").each { |k| total_debt += k.max_payment(end_date, true) }
      h1.store(date[0], total_debt)
    end

    render json: h1.chart_json
  end

  def loans_change_by_month
    h1 = {}

    last_n_months(12).reverse_each do |date|
      end_date = [date[1].end_of_month, Time.now.to_date].min
      prev_end_date = (end_date - 1.month).end_of_month

      total_debt = 0
      prev_total_debt = 0

      current_user.get_all('debt_balances').joins(debt: :category).where("debt_balances.payment_start_date <= '#{end_date}' AND '#{end_date}' <= due_date AND debts.is_asset=false AND categories.name NOT IN ('Rent','Donation/Gift (Recurring)')").each { |k| total_debt += k.max_payment(end_date, true) }
      current_user.get_all('debt_balances').joins(debt: :category).where("debt_balances.payment_start_date <= '#{prev_end_date}' AND '#{prev_end_date}' <= due_date AND debts.is_asset=false AND categories.name NOT IN ('Rent','Donation/Gift (Recurring)')").each { |k| prev_total_debt += k.max_payment(prev_end_date, true) }

      if prev_total_debt > 0
        percent_change = ((total_debt + 0.00000001) / (prev_total_debt + 0.00000001) - 1)
        h1.store(date[0], percent_change)
      end
    end

    render json: h1.chart_json
  end

  # GET /debt_balances/1
  # GET /debt_balances/1.json
  def show
    @debt_balance.new_balance = params[:new_balance]
    @spendings = @debt_balance.payments
                              .order(sort_column + ' ' + sort_direction)
                              .order(updated_at: :desc)
  end

  # GET /debt_balances/new
  def new
    @debt_balance = DebtBalance.new
    set_grouped_items
  end

  # GET /debt_balances/1/edit
  def edit
    set_grouped_items
  end

  # POST /debt_balances
  # POST /debt_balances.json
  def create
    @debt_balance = DebtBalance.new(debt_balance_params)

    respond_to do |format|
      if @debt_balance.save
        format.html { redirect_to @debt_balance, notice: 'Debt balance was successfully created.' }
        format.json { render :show, status: :created, location: @debt_balance }
      else
        format.html { render :new }
        format.json { render json: @debt_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debt_balances/1
  # PATCH/PUT /debt_balances/1.json
  def update
    respond_to do |format|
      if @debt_balance.update(debt_balance_params)
        format.html { redirect_to @debt_balance, notice: 'Debt balance was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt_balance }
      else
        format.html { render :edit }
        format.json { render json: @debt_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debt_balances/1
  # DELETE /debt_balances/1.json
  def destroy
    @debt_balance.destroy
    respond_to do |format|
      format.html { redirect_to debt_balances_url, notice: 'Debt balance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Close a goal/debt/balance
  def close
    @debt_balance.close
    respond_to do |format|
      format.html { redirect_to @debt_balance, notice: 'Debt/Asset balance was successfully closed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debt_balance
    @debt_balance = DebtBalance.find(params[:id])
    authorize @debt_balance
  end

  def set_grouped_items
    debts = current_user.get_all('debts').active.order(:name)
    @grouped_debts = get_grouped(debts)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def debt_balance_params
    params.require(:debt_balance).permit(:debt_id, :due_date, :balance, :payment_start_date, :target_balance)
  end
end
