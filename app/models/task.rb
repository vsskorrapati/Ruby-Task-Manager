class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true

    scope :recent, -> { order(created_at: :desc)}
end
