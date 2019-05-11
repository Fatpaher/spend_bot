FactoryBot.define do
  factory :message_data do
    user

    transient do
      command { :new }
      amount { 1.0 }
      category { :food }
      date { nil  }
      message { "/#{command} #{amount} ##{category} #{date}" }
    end

    initialize_with { new(message, user) }
  end
end
