module Templates
  class Show < Base

    private

    def data
      @data = grouped_events.map do |event|
        "#{event.category} #{event.sum}"
      end

      @data.unshift("Expences for #{month}")
    end
  end
end
