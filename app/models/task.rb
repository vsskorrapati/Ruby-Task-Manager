class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    belongs_to :user
    scope :recent, -> { order(created_at: :desc)}
end
