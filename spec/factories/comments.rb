FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    body { Faker::Shakespeare.king_richard_iii_quote }
  end

end
