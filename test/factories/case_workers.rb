FactoryBot.define do
  factory :case_worker do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    user { nil }
    phone_number { "MyString" }
  end
end
