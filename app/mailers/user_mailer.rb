class UserMailer < ApplicationMailer
  default from: 'no-reply@pokemonisee.com'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: t('defaults.password_reset'))
  end
end
