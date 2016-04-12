require 'rails_helper'

RSpec.describe 'schedules/index', type: :view do
  before(:each) do
    assign(:schedules, [
             Schedule.create!(
               rule: 'MyText'
             ),
             Schedule.create!(
               rule: 'MyText'
             )
           ])
  end

  it 'renders a list of schedules' do
    render
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
