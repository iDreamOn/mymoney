require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:schedule)).to be_valid
  end

  it 'must be unique' do
    FactoryGirl.create(:schedule)
    expect(FactoryGirl.build(:duplicate_schedule)).to_not be_valid
  end

  context 'is invalid when' do
    it 'rule is invalid' do
      schedule = FactoryGirl.build(:schedule, rule: 'invalid')
      expect(schedule).to_not be_valid
    end
  end

  it 'returns the right number of occurrences' do
    schedule = FactoryGirl.build(:schedule)
    expect(schedule.occurrences.size).to eq(0)
    expect(schedule.occurrences(Date.new(2014, 1, 1), Date.new(2014, 12, 31)).size).to eq(52)
    expect(schedule.occurrences(Date.new(2011, 1, 1), Date.new(2016, 12, 31)).size).to eq(313)
  end
end
