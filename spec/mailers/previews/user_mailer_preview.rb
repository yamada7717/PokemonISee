# Preview all emails at http://localhost:3000/rails/mailers/user_mailer_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer_mailer/reset_password_emai
  def reset_password_emai
    UserMailer.reset_password_emai
  end

end
