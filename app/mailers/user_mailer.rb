class UserMailer < ApplicationMailer
  default from: 'notifications@blog-it.com'

  def welcome
    @user = params[:user]
    @url = 'https://blog-it.com/login'
    mail(to: @user.email, subject: 'Welcome to Blog-it !')
  end

  def welcome_author
    @user = params[:user]
    @url = 'https://blog-it.com/login'
    mail(to: @user.email, subject: 'Congratulations, you are an author now!')
  end

  def results_csv
    require 'csv'
    @articles = Article.all
    attachments["articles-#{Date.today}.csv"] =
    # options = { col_sep: ';', encoding: 'utf-8' }
    # headers = %i[id title]
    # {mime_type: 'application/octet-stream', content:
      CSV.generate do |csv|
        csv << ["id", "title"]
        @articles.find_each do |article|
          csv << [article.id, article.title]
        end
      end
    # }
    @user = params[:user]
    mail(to: @user.email, subject: 'Your CSV is ready !')
  end

end
