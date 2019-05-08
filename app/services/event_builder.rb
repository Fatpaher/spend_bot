class EventBuilder
  attr_reader :message_data

  def initialize(message_data)
    @message_data = message_data
  end

  def build
    Event.create!(
      amount: message_data.amount,
      date: message_data.date,
      user_id: message_data.user.id,
      category: message_data.category
    )
  end
end
