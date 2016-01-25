require 'rails_helper'

RSpec.describe 'schedules/new', type: :view do
  before(:each) do
    assign(:schedule, Schedule.new(
                        rule: 'MyText'
    ))
  end

  it 'renders new schedule form' do
    render

    assert_select 'form[action=?][method=?]', schedules_path, 'post' do
      assert_select 'textarea#schedule_rule[name=?]', 'schedule[rule]'
    end
  end
end
