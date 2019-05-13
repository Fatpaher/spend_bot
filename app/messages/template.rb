module Messages
  class Template
    attr_reader :file_path, :template_object

    def initialize(file_path, data)
      @file_path = file_path
      @template_object = TemplateObject.new(data)
    end

    def render
      template = Tilt::ERBTemplate.new(file_path)

      template.
        render(template_object).
        gsub(/^\s+/, '').
        chomp
    end

  end
end
