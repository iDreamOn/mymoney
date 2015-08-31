class SpendingsController < ApplicationController
  include SpendingsHelper

  before_action :set_spending, only: [:show, :edit, :update, :destroy]

  # GET /spendings
  # GET /spendings.json
  def index
    @spendings = Spending.search(params[:search])
                         .order(sort_column + " " + sort_direction)
                         .order(updated_at: :desc)
                         .paginate(page: params[:page])
  end
  
  def spendings_by_day
    render json: Spending.group_by_day(:spending_date, format: "%B %d, %Y")
                         .sum(:amount)
  end
  
  def spendings_by_month
    render json: Spending.group_by_month(:spending_date, format: "%B, %Y")
                         .sum(:amount)
  end

  def spendings_by_category
    render json: Spending.joins("JOIN categories ON spendings.category_id = categories.id")
                         .select("spendings.*, categories.name")
                         .group(:name).sum(:amount)
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
        format.json { render :show, status: :created, location: @spending }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spending_params
      params.require(:spending).permit(:description, :category_id, :spending_date, :amount, :description_select)
    end
end
