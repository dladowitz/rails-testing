FactoryGirl.define do
  factory :contact do
    firstname "Hank"
    lastname "Mcoy"

    sequence(:email) { |n| "hank_mcoy#{n}@example.com"}
  end
end
