FactoryBot.define do
  factory :foster_parent do
    p1_first_name { "MyString" }
    p1_last_name { "MyString" }
    p2_first_name { "MyString" }
    p2_last_name { "MyString" }
    email { "MyString" }
    phone_number { "MyString" }
    user { nil }
    active { "MyString" }
    boolean { "MyString" }
    open_beds { "MyString" }
    integer { "MyString" }
    family_style { "MyString" }
  end
end
