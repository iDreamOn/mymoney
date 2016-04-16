class AddCcPaymentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :cc_payment, :boolean, null: false, default: false
  end
end
