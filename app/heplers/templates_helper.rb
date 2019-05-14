module TemplatesHelper
  def to_text
    Array(data).join("\n")
  end

  def pretty_date(date)
    date.strftime('%d.%m.%y')
  end

  def pretty_currency(amount)
    integer, decimal = sprintf("%0.2f", amount).split('.')

    return integer if decimal.to_i.zero?

    integer.gsub!(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
    "#{integer}.#{decimal}"
  end
end
