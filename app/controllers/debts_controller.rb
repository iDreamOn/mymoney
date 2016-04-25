class DebtsController < ApplicationController
  before_action :set_debt, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /debts
  # GET /debts.json
  def index
    @debts = current_user.get_all('debts').order(:account_id).order(:category_id).order(:sub_category).order(:name).where(deleted_at: nil)
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
    set_grouped_items
  end

  # GET /debts/1/edit
  def edit
    set_grouped_items
  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(debt_params)

    respond_to do |format|
      if @debt.save
        format.html { redirect_to @debt, notice: 'Debt was successfully created.' }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debt
    @debt = Debt.find(params[:id])
    authorize @debt
  end

  def set_grouped_items
    accounts = current_user.get_all('accounts').order(:name)
    @grouped_accounts = get_grouped(accounts)
    categories = current_user.get_all('categories').order(:name)
    @grouped_categories = get_grouped(categories)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def debt_params
    params.require(:debt).permit(:category_id, :sub_category, :name, :is_asset, :account_id, :fix_amount, :schedule, :autopay, :payment_start_date)
  end
end
