module ExportPdf
  extend ActiveSupport::Concern

  module ClassMethods
    def to_pdf
      require 'prawn'
      require 'prawn/table'

      options = { position: :center, column_widths: [50, 300, 200], width: 550 }

      header = %w[id Title Authors]
      data = all.map { |article| [article.id, article.title, article.authors.map(&:full_name).join(', ')] }
      Prawn::Document.new do
        text 'All Articles', align: :center, size: 18, style: :bold
        table([header, *data], header: true, **options)
      end.render
    end
  end
end
