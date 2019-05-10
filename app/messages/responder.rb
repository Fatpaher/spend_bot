Dir['./app/**/*.rb'].each {|file| require file }

module Messages
  class Responder
    attr_reader :message, :bot, :user, :sender

    def initialize(options)
      @bot = options[:bot]
      @message = options[:message]
      @user = options[:user] || User.find_or_create_by(uid: message.from.id)
      @sender = options[:sender] || Sender.new(bot: @bot, chat: @message.chat)
    end

    def respond
      message_data = MessageData.new(message.text, user)
      case message_data.command
      when :new
        Commands::New.new(message_data).call
        answer_with_message(I18n.t(:record_added, scope: :new))
      end
    rescue BlankAmountError
      answer_with_message(I18n.t(:blank_ammount, scope: :errors))
    end

    private

    def answer_with_message(text)
      sender.send(text)
    end
  end
end
