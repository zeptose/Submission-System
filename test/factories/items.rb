FactoryBot.define do
  factory :item do
    name { "Application" }
    instructions { "Please submit the application here." }
    file { "Fillable File will be here." }
    due_date { "Due in 2 weeks after registration." }
    active { true }
    association :category
  end
end
