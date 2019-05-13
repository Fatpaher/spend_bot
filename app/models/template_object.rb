require './app/heplers/templates_helper'

class TemplateObject
  include TemplatesHelper

  def initialize(arg = nil)
    return unless arg

    arg.each do |method_name, value|
      define_singleton_method(method_name) { value }
    end
  end
end
