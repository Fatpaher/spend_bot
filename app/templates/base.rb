module Templates
  class Base
    def initialize(arg=nil)
      return unless arg

      arg.each do |method_name, value|
        define_singleton_method(method_name) { value }
      end
    end

    def to_text
      Array(data).join("\n")
    end
  end
end
