require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /index" do
    it 'returns a success response' do
      get '/tasks'
      # expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      task = create :task
      get '/tasks'
      expect(json_data.length).to eq(1)
      expected = json_data.first
      aggregate_failures do
        expect(expected[:id]).to eq(task.id.to_s)
        expect(expected[:type]).to eq('task')
        expect(expected[:attributes]).to eq(
          name: task.name,
          description: task.description,
        )
      end
    end

    it 'returns tasks in the proper order' do
      older_task =
        create(:task, created_at: 1.hour.ago)
      recent_task = create(:task)
      get '/tasks'
      ids = json_data.map { |item| item[:id].to_i }
      expect(ids).to(
        eq([recent_task.id, older_task.id])
      )
    end

    it 'paginates results' do
      task1, task2, task3 = create_list(:task, 3)
      get '/tasks', params: { page: { number: 2, size: 1 } }
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(task2.id.to_s)
    end

    it 'contains pagination links in the response' do
      task1, task2, task3 = create_list(:task, 3)
      get '/tasks', params: { page: { number: 2, size: 1 } }
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end

  end

  describe '#show' do
    let(:task) { create :task }

    subject { get "/tasks/#{task.id}" }

    before { subject }

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      aggregate_failures do
        expect(json_data[:id]).to eq(task.id.to_s)
        expect(json_data[:type]).to eq('task')
        expect(json_data[:attributes]).to eq(
          name: task.name,
          description: task.description,
        )
      end
    end
  end
end
