class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    input_html_options[:class] << 'btn'
    input_html_options[:onchange] = "readURL(this);"
    out << @builder.file_field(attribute_name, input_html_options)
  end
end
