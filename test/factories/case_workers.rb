FactoryBot.define do
  factory :case_worker do
    first_name { "Lucille" }
    last_name { "Smith" }
    email { |u| "#{u.first_name[0]}#{u.last_name}#{(1..99).to_a.sample}@example.com".downcase }
    association :user
    phone_number { rand(10 ** 10).to_s.rjust(10,'0') }
  end
end