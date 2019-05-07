require './app/reply_markup_formatter'
require './config/app_config'

module Messages
  class Sender
    attr_reader :bot, :text, :chat, :answers, :logger

    def initialize(options)
      @bot = options[:bot]
      @text = options[:text]
      @chat = options[:chat]
      @answers = options[:answers]
      @logger = AppConfig.new.get_logger
    end

    def send
      if reply_markup
        bot.api.send_message(
          chat_id: chat.id,
          text: text,
          reply_markup: reply_markup,
        )
      else
        bot.api.send_message(
          chat_id: chat.id, text: text,
        )
      end

      logger.debug "sending '#{text}' to #{chat.username}"
    end

    private

    def reply_markup
      if answers
        ReplyMarkupFormatter.new(answers).get_markup
      end
    end
  end
end
