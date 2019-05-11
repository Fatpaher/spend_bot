module Templates
  class Base
    def initialize(arg=nil)
      return unless arg
      if arg.is_a? Hash
        arg.each do |method_name, value|
          define_singleton_method(method_name) { value }
        end
      else
        name = arg.try(:table_name) || arg.class.name.underscore
        define_singleton_method(name) { arg }
      end
    end

    def to_text
      Array(data).join('\n')
    end
  end
end
