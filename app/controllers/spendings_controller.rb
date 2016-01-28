class SpendingsController < ApplicationController
  include SpendingsHelper

  before_action :set_spending, only: [:show, :edit, :update, :destroy]

  # GET /spendings
  # GET /spendings.json
  def index
    @spendings = current_user.get_all('spendings')
                 .search(params[:search])
                 .order(sort_column + ' ' + sort_direction)
                 .order(updated_at: :desc)
                 .limit(1000)
                 .paginate(page: params[:page])
  end

  def spendings_by_month
    render json: current_user.real_spendings
      .group_by_month(:spending_date, format: '%b %Y', last: 24)
      .sum(:amount).select { |_k, v| v > 0 }
  end

  def spendings_by_category
    render json: current_user.real_spendings
      .includes(:budget)
      .group('categories.name')
      .sum('spendings.amount')
  end

  def spendings_by_payment_method
    render json: current_user.real_spendings
      .includes(:payment_method)
      .group('payment_methods.name').sum(:amount)
  end

  def cc_purchase_vs_payment
    spendings = [{ name: 'Spending', data: current_user.cc_spendings.group_by_month(:spending_date, format: '%b %Y', last: 24).sum(:amount).select { |_k, v| v > 0 } }]
    payments = [{ name: 'Budget', data: current_user.cc_payments.group_by_month(:budget_month, format: '%b %Y', last: 24).sum(:amount).select { |_k, v| v > 0 } }]
    graph = spendings + payments
    render json: graph
  end

  # GET /spendings/1
  # GET /spendings/1.json
  def show
  end

  # GET /spendings/new
  def new
    @spending = Spending.new
  end

  # GET /spendings/1/edit
  def edit
  end

  # POST /spendings
  # POST /spendings.json
  def create
    @spending = Spending.new(spending_params)

    respond_to do |format|
      if @spending.save
        format.html { redirect_to @spending, notice: 'Spending was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spendings/1
  # PATCH/PUT /spendings/1.json
  def update
    respond_to do |format|
      if @spending.update(spending_params)
        format.html { redirect_to @spending, notice: 'Spending was successfully updated.' }
        format.json { render :show, status: :ok, location: @spending }
      else
        format.html { render :edit }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spendings/1
  # DELETE /spendings/1.json
  def destroy
    @spending.destroy
    respond_to do |format|
      format.html { redirect_to spendings_url, notice: 'Spending was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spending
    @spending = Spending.find(params[:id])
    authorize @spending
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spending_params
    params.require(:spending).permit(:description, :spending_date, :amount, :payment_method_id, :debt_balance_id, :budget_id)
  end
end
