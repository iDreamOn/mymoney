class Budget < ActiveRecord::Base
  belongs_to :category
  delegate :name, to: :category, prefix: true, allow_nil: true

  has_many :spendings

  validates_presence_of :category_id, :budget_month, :amount
  validates :amount, numericality: true

  validates_uniqueness_of :category_id, scope: :budget_month, message: 'already set for this month'

  before_validation do
    self.budget_month = budget_month.change(day: 1) unless budget_month.blank?
  end

  def self.search(search)
    if search
      where(budget_month: search.to_date.change(day: 1))
    else
      where(budget_month: Time.now.to_date.change(day: 1))
    end
  end

  def owner
    category.owner
  end

  def to_s
    category
  end

  def balance
    amount - spendings.sum(:amount)
  end

  def percent_total
    category.cc_payment? ? 0 : amount * 100 / (total_budget + 0.0000001)
  end

  def total_budget
    owner.get_all('budgets').includes(:category).where('categories.cc_payment = ?', false).where(budget_month: budget_month).sum(:amount)
  end
end
