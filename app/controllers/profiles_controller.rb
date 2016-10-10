class ProfilesController < ApplicationController
  def index
    @users = User.all
    @workouts = Workout.all
  end

  def show
    @user = User.find(params[:id])
    if @user.has_role? :guest
      flash[:notice] = "This page is unavailable"
      redirect_to "/workouts"
    end
    @workouts = Workout.where(user_id: params[:id])
  end
end
