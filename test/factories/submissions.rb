FactoryBot.define do
  factory :submission do
    date_completed { "01/01/2023" }
    file { "default.pdf" }
    item { nil }
  end
end
