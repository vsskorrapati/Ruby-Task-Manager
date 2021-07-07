FactoryBot.define do
  factory :task do
    sequence(:name)  { |n| "Task #{n}" }
    sequence(:description) { |n| "This is the description for Task #{n}" }
  end
end
