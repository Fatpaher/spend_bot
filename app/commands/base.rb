module Commands
  class Base
    attr_reader :message_data

    def initialize(message_data)
      @message_data = message_data
    end

    def call; end

    def respond_template
      self.class.name.demodulize.underscore
    end
  end
end
