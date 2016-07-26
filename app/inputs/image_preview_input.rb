# renders a file upload that immediatelly displays the image uploaded
#
# see image-preview-input.js for dynamic code
class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    @builder.wrapper.defaults[:class] = []
    input_html_options[:class] << 'btn'
    out << @builder.file_field(attribute_name, input_html_options)
    out << @builder.button(:submit)
  end
end
