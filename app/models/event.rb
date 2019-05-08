class Event < ApplicationRecord
  belongs_to :user

  def category
    "##{super}"
  end
end
