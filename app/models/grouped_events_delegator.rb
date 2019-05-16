require 'delegate'

class GroupedEventsDelegator < SimpleDelegator
  def percent(total, show = false)
    return unless show

    " - #{((sum.to_f / total) * 100).round(2)}%"
  end
end
