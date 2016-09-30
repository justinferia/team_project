class WelcomeController < ApplicationController
  def index
    if !current_user.nil?
      if current_user.has_role? :guest
      redirect_to '/workouts'
      end
    end
  end
end
