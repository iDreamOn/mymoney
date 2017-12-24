cccclass AccountBalancesController < ApplicationController
  before_action :set_account_balance, only: [:show, :edit, :update, :destroy, :make_payments, :undo_payments]
  before_action :admin_only

  def balances_by_day
    graph = current_user.get_all('accounts').map { |acct| { name: acct.name, data: acct.account_balances.group(:balance_date).sum(:amount).select { |_k, v| v > 0 } } }
    render json: graph
  end

  # GET /account_balances
  # GET /account_balances.json
  def index
    @account_balances = current_user.get_all('account_balances').order(balance_date: :desc, account_id: :desc)
  end

  # GET /account_balances/1
  # GET /account_balances/1.json
  def show
    @account_balances = current_user.get_all('account_balances').where(balance_date: @account_balance.balance_date)
  end

  # GET /account_balances/new
  def new
    @account_balance = AccountBalance.new
    set_grouped_items
  end

  # GET /account_balances/1/edit
  def edit
    set_grouped_items
  end

  # POST /account_balances
  # POST /account_balances.json
  def create
    @account_balance = AccountBalance.new(account_balance_params)

    respond_to do |format|
      if @account_balance.save
        format.html { redirect_to @account_balance, notice: 'Account balance was successfully created.' }
        format.json { render :show, status: :created, location: @account_balance }
      else
        format.html { render :new }
        format.json { render json: @account_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_balances/1
  # PATCH/PUT /account_balances/1.json
  def update
    respond_to do |format|
      if @account_balance.update(account_balance_params)
        format.html { redirect_to @account_balance, notice: 'Account balance was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_balance }
      else
        format.html { render :edit }
        format.json { render json: @account_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_balances/1
  # DELETE /account_balances/1.json
  def destroy
    @account_balance.destroy
    respond_to do |format|
      format.html { redirect_to account_balances_url, notice: 'Account balance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Make the payments
  def make_payments
    notice = 'Payments successfully made.'
    notice = 'Some payments were not successful. Check if there is a budget for that month' unless @account_balance.make_payments

    respond_to do |format|
      format.html { redirect_to @account_balance, notice: notice }
      format.json { render :show, status: :made, location: @account_balance }
    end
  end

  def undo_payments
    @account_balance.undo_payments

    respond_to do |format|
      format.html { redirect_to @account_balance, notice: 'Payments successfully undone.' }
      format.json { render :show, status: :made, location: @account_balance }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account_balance
    @account_balance = AccountBalance.find(params[:id])
    authorize @account_balance
  end

  def set_grouped_items
    accounts = current_user.get_all('accounts').order(:name)
    @grouped_accounts = get_grouped(accounts) || []
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_balance_params
    params.require(:account_balance).permit(:balance_date, :account_id, :amount, :buffer, :debt_balance_id, :paid)
  end
end
