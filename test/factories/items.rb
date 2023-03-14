FactoryBot.define do
  factory :item do
    name { "Application" }
    instructions { "Please submit the file here." }
    file { "Fillable file will be here." }
    due_date { "Due in 2 weeks after registration." }
    active { false }
    association :category
  end
end
