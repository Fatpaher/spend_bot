require './lib/errors/blank_ammount_error'
class MessageData
  attr_reader :message, :user

  def initialize(message, user)
    @message = message
    @user = user
  end

  def amount
    @amount = split_message.detect { |message_part| message_part.is_a?(Numeric) }

    raise BlankAmountError if @amount.blank? && command == :new

    @amount
  end

  def date
    @date = split_message.detect { |message_part| message_part.is_a?(Date) }
    return Date.current if @date.blank?

    @date
  end

  def command
    message =~ /^\/(.\w+)/
    $1&.to_sym || :new
  end

  def category
    message =~ /#(.\w+)/
    $1&.to_sym || :other
  end

  def data
    {
      command: command,
      amount: amount,
      date: date,
      user: user,
    }
  end

  private

  def split_message
    return @split_message if defined?(@split_message)
    @split_message = message.split(/\s+/)

    @split_message = @split_message.map do |message_part|
      to_numeric(message_part) || to_date(message_part) || message_part
    end
  end

  def to_numeric(value)
    Float(value)
  rescue ArgumentError
    nil
  end

  def to_date(value)
    Date.parse value
  rescue ArgumentError
    nil
  end
end
