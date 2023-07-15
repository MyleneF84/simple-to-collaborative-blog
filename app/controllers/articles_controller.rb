class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  include ActionController::Live
  include Articles

  def index
    super
    respond_to do |format|
      format.html
      format.csv { send_stream(filename: "articles-#{Date.today}.csv") do |stream|
          stream.write "id,Title,By:\n"
          @articles.find_each do |article|
            stream.write "#{article.id},#{article.title},#{article.authors.map(&:full_name).join('- ')}\n"
        end
      end
      }
      format.pdf { send_data Article.to_pdf, filename: "articles-#{Date.today}.pdf" }
    end
  end
end
