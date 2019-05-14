require './app/models/application_record'

class Event < ApplicationRecord
  belongs_to :user

  scope(
    :for_month,
    lambda do |date|
      date ||= Date.current

      where(
        'date > :beginning_of_month AND date < :end_of_month',
        beginning_of_month: date.beginning_of_month,
        end_of_month: date.end_of_month,
      )
    end
  )

  scope(
    :for_category,
    lambda do |category|
      return if category.blank?

      where(category: category)
    end,
  )

  def category
    "##{super}"
  end
end
