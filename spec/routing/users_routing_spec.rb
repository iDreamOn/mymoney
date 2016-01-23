require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #add_contributor' do
      expect(get: '/users/1/add_contributor').to route_to('users#add_contributor', id: '1')
    end

    it 'routes to #remove_contributor' do
      expect(get: '/users/1/remove_contributor').to route_to('users#remove_contributor', id: '1')
    end
  end
end
