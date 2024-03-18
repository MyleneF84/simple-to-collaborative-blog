module CustomInputs
  class AuthorNameInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      author_name = object.send(attribute_name).try(:full_name)
      author_id = object.send(attribute_name).try(:id)

      template.content_tag(:div, class: 'input-group') do
        template.concat template.text_field_tag(nil, author_name, merged_input_options.merge(list: "datalist-#{attribute_name}"))
        template.concat template.hidden_field_tag("#{object_name}[#{attribute_name}_id]", author_id)
        template.concat render_datalist(attribute_name)
      end
    end

    private

    def render_datalist(attribute_name)
      authors = Author.all
      datalist_id = "datalist-#{attribute_name}"

      template.content_tag(:datalist, id: datalist_id) do
        authors.map { |author| template.concat template.content_tag(:option, author.full_name, value: author.id) }
      end
    end
  end
end
