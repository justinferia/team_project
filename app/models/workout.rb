class Workout < ActiveRecord::Base
  belongs_to :user
  geocoded_by :location
  after_validation :geocode

  # validates :user, presence: true # add this
end
