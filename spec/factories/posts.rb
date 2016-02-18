FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "#{n}-#{Faker::Shakespeare.hamlet_quote}"}
    sequence(:body) { |n| "#{Faker::Hipster.paragraph(1)}-#{n}" }
  end

end
