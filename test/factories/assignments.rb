FactoryBot.define do
  factory :assignment do
    item { nil }
    foster_parent { nil }
    case_worker { nil }
    due_date { "01/01/2023" }
    # status {"Due in" due_date - current.date}
    completion { true }
  end
end
