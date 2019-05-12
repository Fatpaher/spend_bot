module Queries
  class EventsList
    attr_reader :user, :date, :category

    def initialize(user:, date:, category: )
      @user = user
      @date = date
      @category = category
    end

    def call
      Event.
        where(
          user: user,
        ).
        for_month(date).
        for_category(category).
        order(:date)
    end
  end
end
