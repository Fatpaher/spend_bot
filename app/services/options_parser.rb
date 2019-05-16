class OptionsParser
  OPTIONS = {
    p: :percent,
  }.freeze

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def parse
    options_from_message = message.match(amount_regex)

    return nil unless options_from_message

    options_from_message.captures.first.split('').map do |letter|
      OPTIONS[letter.to_sym]
    end
  end

  private

  def amount_regex
    /-([a-z]+)/
  end

  def to_numeric(value)
    Float(value)
  rescue ArgumentError
    nil
  end
end
