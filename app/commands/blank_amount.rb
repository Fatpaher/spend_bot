require './app/commands/base'

module Commands
  class BlankAmount < Base
    def call
      {
        error_message: error_message
      }
    end

    def respond_template
      'error'
    end

    private

    def error_message
      :blank_amount
    end
  end
end
