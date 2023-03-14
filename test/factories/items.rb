FactoryBot.define do
  factory :item do
    name { "MyString" }
    instructions { "MyString" }
    file { "MyString" }
    due_date { "MyString" }
    active { false }
    category { nil }
  end
end
