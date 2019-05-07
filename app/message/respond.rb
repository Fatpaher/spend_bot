# Dir['./models/*.rb'].each {|file| require file }
require './app/message/send'
require './app/models/application_record'
require './app/models/user'

module Message
  class Respond
    attr_reader :message, :bot, :user

    def initialize(options)
      @bot = options[:bot]
      @message = options[:message]
      @user = User.find_or_create_by(uid: message.from.id)
    end

    def respond
      on(/^\/start/) do
        answer_with_greeting_message
      end

      on(/^\/stop/) do
        answer_with_farewell_message
      end

      on(/^\/command (.+)/) do |arg|
        answer_with_message("you send me #{arg}")
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

    def answer_with_greeting_message
      answer_with_message I18n.t('greeting_message')
    end

    def answer_with_farewell_message
      answer_with_message I18n.t('farewell_message')
    end

    def answer_with_message(text)
      Send.new(bot: bot, chat: message.chat, text: text).send
    end
  end
end
