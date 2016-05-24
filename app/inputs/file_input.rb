class FileInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    markup = template.content_tag :div, class: 'btn' do
      template.content_tag(:span, 'File') +
      @builder.file_field(attribute_name, merged_input_options)
    end
    markup += template.content_tag :div, class: 'file-path-wrapper' do
      @builder.text_field(attribute_name, class: 'file-path validate')
    end
  end
end

