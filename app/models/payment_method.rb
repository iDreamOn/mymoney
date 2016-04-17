class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  has_many :spendings

  validates_presence_of :description, :name, :user, :method_type
  validates_uniqueness_of :name, case_sensitive: false, scope: :user
  validates_uniqueness_of :account, scope: :user, allow_blank: true

  def to_s
    name
  end

  def owner
    user
  end
end
