require './app/commands/base'

module Commands
  class Show < Base
    def call
      {
        grouped_events: grouped_events,
        month: month,
        total: total,
        show_percent?: show_percent?,
      }
    end

    def month
      message_data.date.strftime('%B %Y')
    end

    def grouped_events
      @grouped_events ||= grouped_events_query.map do |event|
        GroupedEventsDelegator.new(event)
      end
    end

    def grouped_events_query
      EventsShowQuery.
        new(
          date: message_data.date,
          user: message_data.user,
          category: message_data.category,
      ).
      call
    end

    def total
      grouped_events_query.
        map(&:sum).
        sum
    end

    def show_percent?
      message_data.options&.include?(:percent)
    end
  end
end
