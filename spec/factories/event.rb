FactoryBot.define do
  factory :event do
    user
    date { Date.yesterday }
  end
end
