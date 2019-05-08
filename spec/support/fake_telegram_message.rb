class FakeTelegramMessage
  attr_accessor :from, :id, :text

  def initialize(options={})
    @from = options[:from]
    @text = options[:text]
  end
end
