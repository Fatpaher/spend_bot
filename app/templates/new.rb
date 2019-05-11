module Templates
  class New < Base

    private

    def data
      I18n.t(:record_added, scope: :new)
    end
  end
end
