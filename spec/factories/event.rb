FactoryBot.define do
  factory :event do
    user
    date { Date.yesterday }
    amount { 1.0 }
  end
end
