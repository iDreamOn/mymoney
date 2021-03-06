class Schedule < ActiveRecord::Base
  include IceCube
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  has_many :income_sources, inverse_of: :schedule

  validates_uniqueness_of :rule
  validate :rule_is_valid, if: proc { |k| k.rule && k.rule != 'null' }

  def to_s
    schedule = IceCube::Schedule.new(Time.now.to_date)
    schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(rule))
    schedule
  end

  def occurrences(from = 1.day.from_now, to = 1.day.ago, base = nil)
    schedule = Schedule.new(base || from)
    schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(rule))
    schedule.occurrences_between(from, to).map(&:to_date)
  end

  def next_occurrence(from = Time.now.to_date, base = nil)
    schedule = Schedule.new(base || from)
    schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(rule))
    result = schedule.next_occurrence(from)
    result.to_date if result
  end

  def previous_occurrence(from = 1.year.ago)
    occurrences(from - 365.day, from).last || 99.year.from_now
  end

  private

  def rule_is_valid
    errors.add(:rule, 'is invalid') unless RecurringSelect.is_valid_rule?(rule)
  end
end
