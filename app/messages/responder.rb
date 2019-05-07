Dir['./app/**/*.rb'].each {|file| require file }

module Messages
  class Responder
    attr_reader :message, :bot, :user

    def initialize(options)
      @bot = options[:bot]
      @message = options[:message]
      @user = User.find_or_create_by(uid: message.from.id)
    end

    def respond
      on(/^\/new (.+)/) do |arg|
        EventBuilder.new(arg).build
      end
    end

    private

    def on regex, &block
      regex =~ message.text

      return unless $~

      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end

    def answer_with_message(text)
      Sender.new(bot: bot, chat: message.chat, text: text).send
    end
  end
end
