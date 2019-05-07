class FakeTelegramMessage
  attr_accessor :from, :id, :text

  def initialize(options={})
    @from = options[:from]
  end
end
