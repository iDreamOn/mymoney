module SpendingsHelper
  def sort_column
    Spending.column_names.include?(params[:order]) ? params[:order] : 'spending_date'
  end

  def sort_direction
    %w(asc desc).include?(params[:sort_mode]) ? params[:sort_mode] : 'desc'
  end
end
