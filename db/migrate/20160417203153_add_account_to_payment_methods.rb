class AddAccountToPaymentMethods < ActiveRecord::Migration
  def change
    add_reference :payment_methods, :account, index: true, foreign_key: true
  end
end
