    require 'rails_helper'

    RSpec.describe '/tasks routes' do
      it 'routes to tasks#index' do
        # expect(get '/tasks').to route_to(controller: 'tasks', action: 'index')
        aggregate_failures do
          expect(get('/tasks')).to route_to('tasks#index')
          expect(get('/tasks?page[number]=3')).to(
            route_to('tasks#index', page: { 'number' => '3' })
          )
        end
      end
    
      it 'routes to tasks#show' do
        expect(get('/tasks/1')).to route_to('tasks#show', id: '1')
      end
    
    it 'should route to tasks create' do
      expect(post '/tasks').to route_to('tasks#create')
    end
  
    it 'should route to tasks update' do
      expect(put '/tasks/1').to route_to('tasks#update', id: '1')
      expect(patch '/tasks/1').to route_to('tasks#update', id: '1')
    end
  
    it 'should route to tasks destroy' do
      expect(delete '/tasks/1').to route_to('tasks#destroy', id: '1')
    end
  end
  