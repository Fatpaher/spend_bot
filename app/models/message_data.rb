class MessageData
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def amount
    split_message.detect { |message_part| message_part.is_a?(Numeric) }
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
    }
  end

  private

  def split_message
    split_message = message.split(/\s+/)

    split_message.map do |message_part|
      message_part.to_f if numeric?(message_part)
    end
  end


  def numeric?(value)
    Float(value) rescue false
  end
end
