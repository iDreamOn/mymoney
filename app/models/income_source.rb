class IncomeSource < ActiveRecord::Base
  include DateModule
  include ScheduleLib

  belongs_to :account
  belongs_to :schedule, inverse_of: :income_sources
  delegate :name, to: :account, prefix: true, allow_nil: true

  accepts_nested_attributes_for :schedule

  validates_presence_of :name, :amount, :start_date, :end_date, :account, :schedule
  validates_numericality_of :amount
  validate :start_and_end

  def owner
    account.owner
  end

  def self.total_income(source_account = nil, from = Date.new(2010, 1, 1), to = Time.now.to_date)
    result = 0
    if source_account.nil?
      IncomeSource.all.each { |k| result += k.income(from, to) }
    else
      IncomeSource.where(account_id: source_account.id).each { |k| result += k.income(from, to) }
    end
    result
  end

  def self.total_paychecks(source_account = nil, from = Date.new(2010, 1, 1), to = Time.now.to_date)
    result = []
    if source_account.nil?
      IncomeSource.all.each { |k| result += k.paychecks(from, to) }
    else
      IncomeSource.where(account_id: source_account.id).each { |k| result += k.paychecks(from, to) }
    end
    result.uniq.size
  end

  def self.max_end_date
    IncomeSource.maximum(:end_date)
  end

  private

  def start_and_end
    return unless start_date && end_date
    errors.add(:start_date, 'must be before end date') unless before?(start_date, end_date)
  end
end
