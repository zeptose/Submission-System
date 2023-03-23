FactoryBot.define do
  factory :user do
    username { "tmp" }
    password { "secret" }
    password_confirmation { "secret" }
    role { "foster_parent" }
    active { false }
  end
end
