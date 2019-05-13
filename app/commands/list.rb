require './app/commands/base'

module Commands
  class List < Base
    def call
      {
        events: events,
        month: month,
      }
    end

    def month
      message_data.date.strftime('%B %Y')
    end

    def events
      Queries::EventsList.
        new(
          date: message_data.date,
          user: message_data.user,
          category: message_data.category,
        ).
        call
    end
  end
end
