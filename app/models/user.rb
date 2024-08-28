class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :profile_image
  has_many :builds, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_builds, through: :likes, source: :build
  has_many :follows, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followings, through: :follows, source: :followed
  has_many :reverse_follows, foreign_key: :followed_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  attr_accessor :remove_profile_image

  validates :name, length: { maximum: 16 }, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }
  validates :introduction, length: { maximum: 255 }, allow_blank: true
  validate :validate_profile_image, if: -> { profile_image.attached? }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def liked?(build)
    liked_builds.include?(build)
  end

  def following?(user)
    followings.include?(user)
  end

  private

  def validate_profile_image
    unless profile_image.blob.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:profile_image, 'はJPEG、PNG、またはGIF形式でなければなりません。')
    end

    if profile_image.blob.byte_size > 5.megabytes
      errors.add(:profile_image, 'のサイズは5MB以下である必要があります。')
    end
  end
end
