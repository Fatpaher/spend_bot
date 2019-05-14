require './app/commands/base'

module Commands
  class Undo < Base
    def call
      {
        event: event,
      }
    end

    def event
      Queries::EventsList.
        new(
          date: message_data.date,
          user: message_data.user,
          category: message_data.category,
        ).
        call.
        last&.
        destroy
    end
  end
end
