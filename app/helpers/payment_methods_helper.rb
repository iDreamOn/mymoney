module PaymentMethodsHelper
  def sort_column
    PaymentMethod.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
