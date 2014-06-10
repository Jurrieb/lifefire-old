class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_reader :avatar_remote_url

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :timeoutable,
         :trackable,
         :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_attached_file :avatar, :styles => { :medium => "300x300>",
                                          :thumb => "100x100>" },
                             :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def self.find_for_facebook_oauth(auth)
    # Find or create user with Facebook credentials
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar_remote_url = auth.info.image # assuming the user model has an image
    end
  end

  def avatar_remote_url=(url_value)
    require 'open-uri'
    require 'open_uri_redirections'

    # Open url with safe redirections
    url_picture = open(url_value, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end

    # Attach to user object
    self.avatar = url_picture

    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/jpg"
    @avatar_remote_url = url_value
  end


end
