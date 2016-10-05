class Workout < ActiveRecord::Base
  belongs_to :user
  geocoded_by :location
  after_validation :geocode
  validates :name, :date, :time, :location, :category, :duration, :level , :description, presence: true

  # validates :user, presence: true # add this
end
