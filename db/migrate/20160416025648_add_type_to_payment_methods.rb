class AddTypeToPaymentMethods < ActiveRecord::Migration
  def change
    add_column :payment_methods, :method_type, :string
  end
end
