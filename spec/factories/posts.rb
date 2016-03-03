FactoryGirl.define do
  factory :post do
    association :user, factory: :user
    sequence(:title) { |n| "#{n}-#{Faker::Shakespeare.hamlet_quote}"}
    sequence(:body) { |n| "#{Faker::Hipster.paragraph(1)}-#{n}" }
  end

end
