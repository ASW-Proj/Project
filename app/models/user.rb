class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :banner
  has_many :posts
  has_many :comments
  has_and_belongs_to_many :communities
  has_many :votes

  has_many :saved_posts, dependent: :destroy
  has_many :saved_comments, dependent: :destroy
  has_many :saved_posts, through: :saved_posts, source: :post
  has_many :saved_comments, through: :saved_comments, source: :comment

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
