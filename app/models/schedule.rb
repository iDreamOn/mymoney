class Schedule < ActiveRecord::Base
  include IceCube
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  has_many :income_sources, inverse_of: :schedule

  validates_uniqueness_of :rule
  validate :rule_is_valid, if: proc { |k| k.rule && k.rule != 'null' }

  def to_s
    schedule = Schedule.new(Time.now.to_date)
    schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(rule))
    schedule
  end

  def occurrences(from = Time.now.to_date, to = Time.now.to_date)
    schedule = Schedule.new(from)
    schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(rule))
    schedule.occurrences_between(from, to).map(&:to_date)
  end

  private

  def rule_is_valid
    errors.add(:rule, 'is invalid') unless RecurringSelect.is_valid_rule?(rule)
  end
end