require 'rails_helper'

RSpec.describe IncomeSource, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:income_source)).to be_valid
  end

  context 'is invalid when' do
    it "doesn't belong to an account" do
      income_source = FactoryGirl.build(:income_source, account: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:account)
    end

    it 'amount is empty' do
      income_source = FactoryGirl.build(:income_source, amount: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:amount)
    end

    it 'amount is not a number' do
      income_source = FactoryGirl.build(:income_source, amount: 'test')
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:amount)
    end

    it 'end date is empty' do
      income_source = FactoryGirl.build(:income_source, end_date: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:end_date)
    end

    it 'start date is empty' do
      income_source = FactoryGirl.build(:income_source, start_date: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:start_date)
    end

    it 'name is empty' do
      income_source = FactoryGirl.build(:income_source, name: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:name)
    end

    it 'pay schedule is empty' do
      income_source = FactoryGirl.build(:income_source, schedule: nil)
      expect(income_source).to_not be_valid
      expect(income_source.errors).to have_key(:schedule)
    end
  end

  context 'returns the right number of paychecks' do
    it 'for single source' do
      income_source = FactoryGirl.build(:income_source)
      expect(income_source.paychecks(Date.new(2013, 1, 1), Date.new(2018, 1, 1)).size).to eq(209)
      expect(income_source.paychecks(Date.new(2015, 1, 1), Date.new(2016, 1, 1)).size).to eq(53)
    end

    it 'for total of multiple sources' do
      FactoryGirl.create(:income_source)
      FactoryGirl.create(:biweekly_income_source)
      FactoryGirl.create(:semi_monthly_income_source)
      expect(IncomeSource.total_paychecks(nil, Date.new(2013, 1, 1), Date.new(2018, 1, 1))).to eq(291)
      expect(IncomeSource.total_paychecks(nil, Date.new(2015, 1, 1), Date.new(2016, 1, 1))).to eq(75)
    end

    it 'for total of multiple sources per account' do
      account = FactoryGirl.create(:account)
      FactoryGirl.create(:income_source, account: account)
      FactoryGirl.create(:biweekly_income_source, account: account)
      FactoryGirl.create(:semi_monthly_income_source)
      expect(IncomeSource.total_paychecks(account, Date.new(2013, 1, 1), Date.new(2018, 1, 1))).to eq(209)
      expect(IncomeSource.total_paychecks(account, Date.new(2015, 1, 1), Date.new(2016, 1, 1))).to eq(53)
    end
  end

  context 'returns the right income amount' do
    it 'for single source' do
      income_source = FactoryGirl.build(:income_source)
      expect(income_source.income(Date.new(2013, 1, 1), Date.new(2018, 1, 1))).to eq(209_000)
      expect(income_source.income(Date.new(2015, 1, 1), Date.new(2016, 1, 1))).to eq(53_000)
    end

    it 'for total of multiple sources' do
      FactoryGirl.create(:income_source)
      FactoryGirl.create(:semi_monthly_income_source)
      expect(IncomeSource.total_income(nil, Date.new(2013, 1, 1), Date.new(2018, 1, 1))).to eq(305_000)
      expect(IncomeSource.total_income(nil, Date.new(2015, 1, 1), Date.new(2016, 1, 1))).to eq(77_000)
    end

    it 'for total of multiple sources per account' do
      account = FactoryGirl.create(:account)
      FactoryGirl.create(:income_source, account: account)
      FactoryGirl.create(:semi_monthly_income_source, account: account)
      FactoryGirl.create(:biweekly_income_source)
      expect(IncomeSource.total_income(account, Date.new(2013, 1, 1), Date.new(2018, 1, 1))).to eq(305_000)
      expect(IncomeSource.total_income(account, Date.new(2015, 1, 1), Date.new(2016, 1, 1))).to eq(77_000)
    end
  end
end
