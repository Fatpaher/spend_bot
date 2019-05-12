module TemplatesHelper
  def to_text
    Array(data).join("\n")
  end

  def pretty_date(date)
    date.strftime('%d.%m.%y')
  end
end
