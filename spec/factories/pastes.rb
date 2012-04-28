require 'faker'

FactoryGirl.define do
  factory :paste do |f|
    f.code Faker::Lorem.paragraphs(3).join("\n")
    f.name "#{Faker::Lorem.words(1).join}.txt"
    f.syntax "text"
  end
end
