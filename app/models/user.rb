class User < ActiveRecord::Base

  include PublicActivity::Common

  # Relations
  has_one :userPreference,      dependent: :destroy
  has_one :userDetail,          dependent: :destroy
  has_one :userNotice,          dependent: :destroy
  has_one :userSmokeAddiction,  dependent: :destroy
  has_one :userProfile,         dependent: :destroy
  has_many :smokes,             dependent: :destroy
  has_many :sports,             dependent: :destroy
  has_many :messages,           dependent: :destroy
  has_many :comments,           dependent: :destroy
  has_many :messages,           dependent: :destroy
  has_many :achievements,       dependent: :destroy

  # Self referential relation
  has_many :friendships,        dependent: :destroy
  has_many :friends, foreign_key: 'friend_id',
                     source: :friend,
                     through: :friendships,
                     dependent: :destroy

  # Concerns
  include Smoking
  include Sporting
  include Messaging
  include KarmaCalculation

  # Friendly ID
  extend FriendlyId
  friendly_id :name, use: :slugged

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
  has_attached_file :avatar, styles: { medium: '300x300#',
                                       thumb: '40x40#' },
                             convert_options: { medium: '-quality 80 -interlace Plane',
                                                thumb: '-quality 80 -interlace Plane' },
                             default_url: '/missing/lifefire_user.jpg'

  # Validations
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
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
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_remote_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.user_hash = Digest::SHA1.hexdigest("#{user.name}-#{user.email}")
    end
  end

  # Fetch and parse remote Facebook image
  def avatar_remote_url=(url_value)
    require 'open-uri'
    require 'open_uri_redirections'

    # Open url with safe redirections
    url_picture = open(url_value, allow_redirections: :safe) do |r|
      r.base_uri.to_s
    end

    # Set image to the user
    self.avatar = url_picture if self.avatar.blank?
    avatar_remote_url = url_picture
  end

  # Check if user has settings and details
  def first_time_user?
    if userDetail.height                      == 0 &&
       userDetail.weight                      == 0 &&
       userDetail.target_weight               == 0 &&
       userPreference.smokes                  == false &&
       userPreference.sports                  == false &&
       userSmokeAddiction.avarage_smokes_day  == 0
      return true
    else
      return false
    end
  end

  # Create needed relations in sign_in
  def create_relations
    UserPreference.create(user_id: id)     unless userPreference.present?
    UserProfile.create(user_id: id)        unless userProfile.present?
    UserDetail.create(user_id: id)         unless userDetail.present?
    UserNotice.create(user_id: id)         unless userNotice.present?
    UserSmokeAddiction.create(user_id: id) unless userSmokeAddiction.present?
  end

  # Publish a private message
  def publish message
    # Require Pusher
    require 'pusher'
    # Publish to url
    Pusher.url = "http://#{Rails.application.secrets.pusher_app_key}:#{Rails.application.secrets.pusher_app_secret}@api.pusherapp.com/apps/#{Rails.application.secrets.pusher_app_id}"
    # Publish channel, event and message
    Pusher[self.user_hash].trigger('event', {
      message: message
    })
  end
end
