require './app/commands/base'

module Commands
  class Show < Base
    def call
      {
        grouped_events: grouped_events,
        month: month,
      }
    end

    def month
      message_data.date.strftime('%B %Y')
    end

    def grouped_events
      EventsShowQuery.
        new(
          date: message_data.date,
          user: message_data.user,
          category: message_data.category,
        ).
        call
    end
  end
end
