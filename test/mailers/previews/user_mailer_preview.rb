# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.first
    UserMailer.with(user: user).welcome
  end

  def welcome_author
    user = User.first
    UserMailer.with(user: user).welcome_author
  end

  def results_csv
    user = User.first
    UserMailer.with(user: user).results_csv
  end

end
