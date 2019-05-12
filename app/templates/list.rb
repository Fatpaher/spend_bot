module Templates
  class List < Base
    private

    def data
      @data = events.map do |event|
        "#{pretty_date(event.date)} #{event.category} - #{event.amount}"
      end

      @data.unshift("Operations in #{month}")
    end
  end
end
