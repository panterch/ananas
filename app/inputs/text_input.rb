class TextInput < SimpleForm::Inputs::TextInput

  # simple_form textarea adaption for materialzecss
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    # add class needed by materialize
    merged_input_options[:class] << 'materialize-textarea'
    @builder.text_area(attribute_name, merged_input_options)
  end
end
