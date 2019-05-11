module Templates
  class Error < Base
    private

    def data
      I18n.t(error_message, scope: :errors)
    end
  end
end
