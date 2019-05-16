class AmountParser
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def parse
    amount_from_message = message.match(amount_regex).to_s

    to_numeric(amount_from_message)
  end

  private

  def amount_regex
    /([\s\b]|^)\d+([\.]\d+)?([\s\b]|$)/
  end

  def to_numeric(value)
    Float(value)
  rescue ArgumentError
    nil
  end
end
