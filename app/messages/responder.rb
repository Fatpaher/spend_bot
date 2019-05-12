Dir['./app/**/*.rb'].each {|file| require file }
require 'tilt'
require 'erb'

module Messages
  class Responder
    VALID_COMMANDS = [
      :new,
      :show,
      :blank_amount,
      :list,
    ]

    attr_reader :message, :bot, :user, :sender

    def initialize(options)
      @bot = options[:bot]
      @message = options[:message]
      @user = options[:user] || User.find_or_create_by(uid: message.from.id)
      @sender = options[:sender] || Sender.new(bot: @bot, chat: @message.chat)
    end

    def respond
      message_data = MessageData.new(message.text, user)

      if VALID_COMMANDS.include?(message_data.command)
        command = command(message_data.command).new(message_data)
        command_result = command.call

        respond_message = respond_template(command.respond_template, command_result)

        answer_with_message(respond_message)
      end
    end

    private

    def command(name)
      Commands.const_get(name.to_s.classify)
    end

    def respond_template(name, result)
      template = Tilt::ERBTemplate.new("./app/templates/#{name}.erb")
      template_object = TemplateObject.new(result)
      template.render(template_object).
        gsub(/^\s+/, '').
        chomp
    end

    def answer_with_message(text)
      sender.send(text)
    end
  end
end
