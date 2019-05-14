class EventsShowQuery
  attr_reader :user, :date, :category

  def initialize(user:, date:, category:)
    @user = user
    @date = date
    @category = category
  end

  def call
    Event.
      group(:category).
      where(
        user: user,
      ).
      for_month(date).
      select('sum(events.amount) AS sum, events.category').
      order(sum: :desc)
  end
end
