class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :profile_image

  validates :name, length: { maximum: 30 }, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }
  validates :introduction, length: { maximum: 255 }, allow_blank: true
  validate :profile_image, if: -> { profile_image.attached? }

  private

  def profile_image
    unless profile_image.blob.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:profile_image, 'はJPEG、PNG、またはGIF形式でなければなりません。')
    end

    if profile_image.blob.byte_size > 5.megabytes
      errors.add(:profile_image, 'のサイズは5MB以下である必要があります。')
    end
  end
end
