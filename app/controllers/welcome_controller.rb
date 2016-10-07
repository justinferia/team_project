class WelcomeController < ApplicationController
  def index
    @workouts = Workout.all
    @pindrop = Gmaps4rails.build_markers(@workouts) do |workout, marker|
      marker.lat workout.latitude
      marker.lng workout.longitude
      marker.infowindow ("<strong>Class : " + workout.name + "<br> Instructor : " + workout.user.name + "<br> Time : " + workout.time.strftime('%r') +"</strong>")
    end
  end
end
