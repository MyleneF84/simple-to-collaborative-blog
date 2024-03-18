module CustomInputs
  class DatalistInput < SimpleForm::Inputs::Base
    def input(wrapper_options = nil)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      template.content_tag(:div, class: 'datalist') do
        template.concat @builder.text_field(attribute_name, merged_input_options)
        template.concat template.tag.datalist(options[:list]) if options[:list].present?
      end
    end
  end
end
