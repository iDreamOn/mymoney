module AccountsHelper
  def sort_column
    Account.column_names.include?(params[:order]) ? params[:order] : 'name'
  end

  def sort_direction
    %w(asc desc).include?(params[:sort_mode]) ? params[:sort_mode] : 'desc'
  end
end
