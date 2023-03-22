FactoryBot.define do
  factory :user do
    username { "MyString" }
    password_digest { "MyString" }
    role { "MyString" }
    active { false }
  end
end
