class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :recoverable, :confirmable, :lockable

  has_many :categories
  has_many :budgets, through: :categories
  has_many :payment_methods
  has_many :spendings, through: :payment_methods
  has_many :accounts
  has_many :income_sources, through: :accounts
  has_many :debts, through: :accounts
  has_many :account_balances, through: :accounts
  has_many :debt_balances, through: :debts
  has_many :account_balance_distributions, through: :account_balances

  has_and_belongs_to_many :contributors,
                          autosave: true,
                          class_name: 'User',
                          join_table: :user_contributors,
                          foreign_key: :user_id,
                          association_foreign_key: :contributor_user_id

  before_save do
    self.email = email.downcase unless email.nil?
    self.email = nil if !email.nil? && email.empty?
    # #TODO: Remove when email is fixed
    skip_confirmation!
    skip_confirmation_notification!
    skip_reconfirmation!
  end

  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :username, presence: true, length: { maximum: 20 }, allow_blank: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    allow_blank: false

  def real_spendings
    get_all('spendings').joins(budget: :category).where("categories.name <> 'Credit Cards'")
  end

  def cc_spendings
    get_all('spendings').joins(:payment_method).where("payment_methods.name = 'Credit'")
  end

  def cc_payments
    get_all('spendings').joins(budget: :category).where("categories.name = 'Credit Cards'")
  end

  def real_budgets
    get_all('budgets').includes(:category).where("categories.name <> 'Credit Cards'")
  end

  def authorize(user = nil)
    id == user.id
  end

  def get_all(attribute)
    model = attribute.strip.underscore.singularize.camelize.constantize
    singular = ActiveModel::Naming.singular(model)
    plural = ActiveModel::Naming.plural(model)
    ids = send("#{singular}_ids")
    contributors.map { |c| ids += c.send("#{singular}_ids") if c.contributors.include?(self) && contributors.include?(c) }
    model.where("#{plural}.id IN (?)", ids)
  end

  def owner
    self
  end
end
