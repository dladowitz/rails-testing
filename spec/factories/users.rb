require "faker"

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { 123456 }
    password_confirmation { 123456 }

    factory :admin do
      admin true
    end

    factory :editor do
      editor true
    end
  end
end
