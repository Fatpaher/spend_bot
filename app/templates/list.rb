module Templates
  class List < Base
    private

    def data
      @data = events.map do |event|
        "#{event.date.strftime('%d.%m.%y')} #{event.category} - #{event.amount}"
      end

      @data.unshift("Operations in #{month}")
    end
  end
end
