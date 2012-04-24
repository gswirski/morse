require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.username Faker::Internet.user_name

    password = Faker::Name.name
    f.password password
    f.password_confirmation password
  end
end
