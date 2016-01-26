class IncomeSource < ActiveRecord::Base
  include DateModule

  # recuring model
  include IceCube
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  belongs_to :account
  delegate :name, to: :account, prefix: true, allow_nil: true

  validates_presence_of :name, :schedule, :amount, :start_date, :end_date, :account
  validates_numericality_of :amount

  validate :start_and_end

  serialize :schedule, Hash

  def schedule=(new_schedule)
    write_attribute(:schedule, RecurringSelect.dirty_hash_to_rule(new_schedule).to_hash) unless new_schedule.nil?
  end

  def converted_schedule
    the_schedule = Schedule.new(start_date)
    the_schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(schedule)) unless schedule.blank?
    the_schedule
  end

  def owner
    account.owner
  end

  def paychecks(from = Time.now.to_date, to = Time.now.to_date)
    from = [from, start_date].max
    to = [to, end_date].min
    converted_schedule.occurrences_between(from, to).map(&:to_date)
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
