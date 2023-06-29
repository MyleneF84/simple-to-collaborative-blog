# module ExportCsv
#   extend ActiveSupport::Concern

#   module ClassMethods
#     def to_csv
#       require 'csv'
#       options = { col_sep: ';', encoding: 'utf-8' }
#       headers = %i[id title]

#       CSV.generate(headers: true, **options) do |csv|
#         csv << headers

#         all.each do |article|
#           csv << [article.id, article.title]
#         end
#       end
#     end
#   end
# end
