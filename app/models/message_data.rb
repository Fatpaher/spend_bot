require './lib/errors/blank_ammount_error'

class MessageData
  attr_reader :message, :user

  def initialize(message, user)
    @message = message.downcase.gsub(/s+/, 's')
    @user = user
  end

  def amount
    @amount ||= split_message.detect { |message_part| message_part.is_a?(Numeric) }
  end

  def date
    @date ||= DateParser.new(message).parse
  end

  def command
    return @command if defined?(@command)

    message =~ /^\/(.\w+)/
    @command = $1&.to_sym || :new

    @command = :blank_amount if amount.blank? && @command == :new

    @command
  end

  def category
    return @category if defined?(@category)

    message =~ /#(.\w+)/
    @category = $1&.to_sym

    @category = :other if @category.blank? && command == :new

    @category
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
      to_numeric(message_part) || message_part
    end
  end

  def to_numeric(value)
    Float(value)
  rescue ArgumentError
    nil
  end
end
