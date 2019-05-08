require './lib/errors/blank_ammount_error'
class MessageData
  attr_reader :message, :user

  def initialize(message, user)
    @message = message
    @user = user
  end

  def amount
    amount = split_message.detect { |message_part| message_part.is_a?(Numeric) }

    raise BlankAmountError if amount.blank? && command == :new

    amount
  end

  def date
    Date.today
  end

  def command
    message[(/^\/.\w+/)].delete('/').to_sym
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
      message_part.to_f if numeric?(message_part)
    end
  end

  def numeric?(value)
    Float(value) rescue false
  end
end
