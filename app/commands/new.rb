module Commands
  class New < Base
    def call
      {
        event: event,
      }
    end

    def event
      Event.create(
        amount: message_data.amount,
        date: message_data.date,
        user_id: message_data.user.id,
        category: message_data.category
      )
    end
  end
end
