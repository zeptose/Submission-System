FactoryBot.define do
  factory :parent do
    p1_first_name { "Annie" }
    p1_last_name { "Eng" }
    p2_first_name { "Ryan" }
    p2_last_name { "McGrady" }
    email { |u| "#{u.first_name[0]}#{u.last_name}#{(1..99).to_a.sample}@example.com".downcase }
    phone_number { rand(10 ** 10).to_s.rjust(10,'0') }
    association :user
    active { true }
    open_beds { rand(1..9) }
    family_style { "Bedding" }
  end
end