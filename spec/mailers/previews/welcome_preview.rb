# Preview all emails at http://localhost:3000/rails/mailers/welcome
class WelcomePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome/welcome
  def welcome
    user = User.first
    WelcomeMailer.welcome(user)
  end

end
