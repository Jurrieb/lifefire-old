class User < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Relations
  has_one :userPreference
  has_one :userDetail
  has_one :userNotice
  has_one :userSmokeAddiction
  has_one :userProfile
  has_many :smokes
  has_many :sports
  has_many :messages
  has_and_belongs_to_many :friends,
    :class_name => "User",
    :association_foreign_key => "friend_id",
    :join_table => "friends_users"

  # Concerns
  include Smoking
  include Sporting
  include Messaging

  # Nested attributes for forms
  accepts_nested_attributes_for :userPreference,
                                :userDetail,
                                :userNotice,
                                :userSmokeAddiction,
                                update_only: true

  # Set extra attribute for remote image
  attr_reader :avatar_remote_url

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Attached profile picture
  has_attached_file :avatar, styles: { medium: "300x300#",
                                       thumb: "40x40#" },
                             default_url: "/images/:style/missing.png",
                             convert_options: {
                                medium: '-quality 80 -interlace Plane',
                                thumb: '-quality 80 -interlace Plane' },
                             default_url: 'missing/lifefire_user.jpg'

  # Validations
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name,
            :email,
            :uid,
            :provider,
            presence: true

  # Find or Create user with Facebook credentials
  def self.find_for_facebook_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar_remote_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

  # Fetch and parse remote Facebook image
  def avatar_remote_url=(url_value)
    require 'open-uri'
    require 'open_uri_redirections'

    # Open url with safe redirections
    url_picture = open(url_value, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end

    # Set image to the user
    self.avatar = url_picture
    avatar_remote_url = url_picture
  end

  # Check if user has settings and details
  def first_time_user?
    if self.userDetail.height                      == 0 &&
       self.userDetail.weight                      == 0 &&
       self.userDetail.target_weight               == 0 &&
       self.userPreference.smokes                  == false &&
       self.userPreference.sports                  == false &&
       self.userSmokeAddiction.avarage_smokes_day  == 0
      return true
     else
      return false
    end
  end

  # Create needed relations in sign_in
  def create_relations
    UserPreference.create(user_id: self.id) unless self.userPreference.present?
    UserProfile.create(user_id: self.id) unless self.userProfile.present?
    UserDetail.create(user_id: self.id) unless self.userDetail.present?
    UserNotice.create(user_id: self.id) unless self.userNotice.present?
    UserSmokeAddiction.create(user_id: self.id) unless self.userSmokeAddiction.present?
  end

  # User is following quit-smoking program?
  def smokes?
    self.userPreference.smokes?
  end

  # User is following sports program
  def sports?
    self.userPreference.sports?
  end

end
