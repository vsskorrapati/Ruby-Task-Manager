require 'rails_helper'

RSpec.describe Task, type: :model do

  describe '#validations' do

    it 'should test that the factory is valid' do
      expect(build :task).to be_valid
    end

    it 'should validate the presence of the name' do
      task = build :task, name: ''
      expect(task).not_to be_valid
      expect(task.errors.messages[:name]).to include("can't be blank")
    end

    it 'should validate the presence of the description' do
      task = build :task, description: ''
      expect(task).not_to be_valid
      expect(task.errors.messages[:description]).to include("can't be blank")
    end

  end

  describe '.recent' do
    it 'should list recent task first' do
      old_task = create :task
      newer_task = create :task
      expect(described_class.recent).to eq(
        [ newer_task, old_task ]
      )
      old_task.update_column :created_at, Time.now
      expect(described_class.recent).to eq(
        [ old_task, newer_task ]
      )
    end
  end

end