# creates datetime input fields suitable for javascript picker rendering
# see materialize-adoptions.js
class DateTimeInput < SimpleForm::Inputs::DateTimeInput

  def input(wrapper_options)
    template.content_tag :div, class: "row" do
      # input field to render datepicker
      markup = template.content_tag :div, class: "input-field col s6 date" do
        @builder.send(:date_field, attribute_name, class: "datepicker")
      end
      # input field to render timepicker
      markup += template.content_tag :div, class: "input-field col s6 time" do
       @builder.send(:time_field, attribute_name, class: 'timepicker')
      end
      # input field for datetime submission
      markup += @builder.send(:hidden_field, attribute_name)
    end
  end
end
