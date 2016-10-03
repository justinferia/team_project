class User < ActiveRecord::Base
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image,
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { in: 0..10.megabytes }

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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

end
