Dir['./app/**/*.rb'].each {|file| require file }

module Messages
  class Responder
    attr_reader :message, :bot, :user

    def initialize(options)
      @bot = options[:bot]
      @message = options[:message]
      @user = options[:user] || User.find_or_create_by(uid: message.from.id)
    end

    def respond
      message_data = MessageData.new(message.text, user)
      EventBuilder.new(message_data).build
    rescue BlankAmountError
      answer_with_message('Hey you forgot to add ammount')
    end

    private

    def answer_with_message(text)
      Sender.new(bot: bot, chat: message.chat, text: text).send
    end
  end
end
