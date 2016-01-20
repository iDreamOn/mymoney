class PaymentMethod < ActiveRecord::Base
  belongs_to :user

  has_many :spendings

  validates_presence_of :description, :name, :user
  validates_uniqueness_of :name, case_sensitive: false, scope: :user

  def to_s
    name
  end

  def owner
    user
  end
end
