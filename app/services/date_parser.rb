class DateParser
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def parse
    date_from_message = message.match(date_regex).to_s

    (to_date(date_from_message) || Date.current)
  end

  private

  def to_date(date_string)
    date_string = four_digits_year(date_string)

    Date.parse(date_string)
  rescue ArgumentError
    nil
  end

  def four_digits_year(date_string)
    return date_string unless date_string =~ /[\s\.](\d{2})$/

    date_string.gsub(/[\s\.]\d{2}$/, ".#{Date.today.year.to_s[0..1]}#{$1}")
  end

  def date_regex
    /([\s\b]|^)#{day_regex}(#{monthes_regex}|\d{2})[\s\.]{0,1}#{year_regexp}/
  end

  def monthes_regex
    /jan(uary)?|feb(ruary)?|mar(ch)?|apr(il)?|may|jun(e)?|jul(y)?|aug(ust)?|sep(tember)?|oct(ober)?|(nov|dec)(ember)?/
  end

  def day_regex
    /(\d{2}[\.\s]){0,1}/
  end

  def year_regexp
    /((2\d{3})|(\d{2})|\b)/
  end
end
