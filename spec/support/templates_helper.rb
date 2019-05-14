module TemplatesHelper
  def render_template(file_name, options = {})
    Messages::Template.
      new(
        "./app/templates/#{file_name}.erb",
        options,
    ).
    render

  end
end
