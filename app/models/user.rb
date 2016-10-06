class User < ActiveRecord::Base
  validates :interests, presence: true, if: :check_role
  validates :fitness_background, presence: true, if: :check_role

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image,
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { in: 0..10.megabytes }

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  def check_role
    has_role? :instructor
  end

# make sure if the name is not present that there is something to fill the space (validation for name)
  def name
    if first_name.present? && last_name.present?
      first_name + " " + last_name
    elsif first_name.present? && last_name.blank?
      first_name
    elsif first_name.blank? && last_name.present?
      last_name
    else
      "No Name"
    end
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@twitter.com"
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
      end
    end
  end
end
