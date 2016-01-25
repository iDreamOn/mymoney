class IncomeSource < ActiveRecord::Base
  include DateModule

  belongs_to :account
  belongs_to :schedule, inverse_of: :income_sources
  delegate :name, to: :account, prefix: true, allow_nil: true

  accepts_nested_attributes_for :schedule

  validates_presence_of :name, :amount, :start_date, :end_date, :account, :schedule
  validates_numericality_of :amount
  validate :start_and_end

  def schedule_attributes=(attrs)
    self.schedule = Schedule.find_or_initialize_by(attrs)
  end

  def owner
    account.owner
  end

  def paychecks(from = Time.now.to_date, to = Time.now.to_date)
    from = [from, start_date].max
    to = [to, end_date].min
    if schedule
      schedule.occurrences(from, to)
    else
      []
    end
  end

  def income(from = Time.now.to_date, to = Time.now.to_date)
    paychecks(from, to).size * amount
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
