class BudgetsController < ApplicationController
  include SpendingsHelper
  include DateModule

  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  FLOOR = '2014-01-01'

  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = current_user.get_all('budgets')
               .joins(:category)
               .search(params[:search])
               .order('categories.name')
               .where("budget_month >= '#{FLOOR}'")
    @curr_budget = (params[:search] || Time.now.to_date.change(day: 1)).to_date
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @spendings = @budget.spendings
                 .order(sort_column + ' ' + sort_direction)
                 .order(updated_at: :desc)
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  def budgets_by_month
    h1 = {}

    last_n_months(24).reverse_each do |date|
      end_date = date[1].end_of_month
      total_income = current_user.get_all('income_sources').total_income(nil, date[1], end_date)
      h1.store(date[0], total_income)
    end

    spendings = [{ name: 'Spending', data: current_user.real_spendings.group_by_month(:spending_date, format: '%b %Y', last: 25).sum(:amount) }]
    budgets = [{ name: 'Budget', data: current_user.real_budgets.group_by_month(:budget_month, format: '%b %Y', last: 25).sum(:amount) }]
    incomes = [{ name: 'Income', data: h1 }]
    graph = spendings + budgets + incomes
    render json: graph
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_budget
    @budget = Budget.find(params[:id])
    authorize @budget
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def budget_params
    params.require(:budget).permit(:category_id, :budget_month, :amount)
  end
end
