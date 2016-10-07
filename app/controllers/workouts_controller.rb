class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :get_workouts, :search]

  # GET /workouts
  # GET /workouts.json
  def index
    if !current_user.nil?
      if current_user.roles.blank?
        redirect_to "/users/role"
      end
    end
    @workouts = Workout.all
    @users = User.all
  end

  # def search
  #   if (params[:search1].nil? || params[:search1].strip.empty?) && (params[:search2].nil? || params[:search2].strip.empty?)
  #     @workouts = Workout.all
  #   elsif
  #   params[:search2].nil? || params[:search2].strip.empty?
  #     @workouts = Workout.search(params[:search1])
  #   elsif
  #   params[:search1].nil? || params[:search1].strip.empty?
  #     @workouts = Workout.search(params[:search2])
  #   else
  #     @workouts = Workout.search(params[:search1])
  #     @workouts = @workouts.search(params[:search2])
  #   end
  #   render :index
  # end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
  end

  # GET /workouts/new
  def new
    if !current_user.has_role? :instructor
      flash[:notice] = 'You must be an instructor to create a workout'
      redirect_to '/workouts/'
    else
    @workout = Workout.new
    end
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = Workout.new(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: 'Workout was successfully created.' }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #this is to populate the calendar in workouts index, returns json
  # takes params search1 and search2
  def get_workouts

    if params[:search1].strip.empty? && params[:search2].strip.empty? && params[:search3].strip.empty?
      @workouts = Workout.all
    elsif
    params[:search2].strip.empty? && params[:search3].strip.empty?
      @workouts = Workout.search(params[:search1])
    elsif
    params[:search1].strip.empty? && params[:search3].strip.empty?
      @workouts = Workout.search(params[:search2])
    elsif
    params[:search1].strip.empty? && params[:search2].strip.empty?
      @workouts = Workout.where(user_id: params[:search3])
    elsif
      params[:search3].strip.empty?
      @workouts = Workout.search(params[:search1])
      @workouts = @workouts.search(params[:search2])
    elsif
      params[:search2].strip.empty?
      @workouts1 = Workout.search(params[:search1])
      @workouts = @workouts1.where(user_id: params[:search3])
    elsif
      params[:search1].strip.empty?
      @workouts2 = Workout.search(params[:search2])
      @workouts = @workouts2.where(user_id: params[:search3])
    else
      @workouts1 = Workout.search(params[:search1])
      @workouts2 = @workouts1.search(params[:search2])
      @workouts = @workouts2.where(user_id: params[:search3])
    end
    # gets every workout in our database
    # collection of data for all of the workouts to be displayed
    workouts = []
    @workouts.each do |workout|
      # value ? a : b means if value is true, do a.  If value is false, do b. (inline if statement)
      #for each workout shouvel data to display into the workouts array
      user = workout.user.present? ? workout.user.name : nil
      image = workout.user.present? ? workout.user.image.url : nil
      workouts << { id: workout.id, title: workout.name, start:DateTime.new(workout.date.year, workout.date.month, workout.date.day, workout.time.hour, workout.time.min, workout.time.sec).to_s, instructor:  user, description:workout.description, location: workout.location, date:workout.date, category: workout.category, duration: workout.duration, level:workout.level, time:workout.time.strftime('%r'), image: workout.user.image.url

      }
    end
    # changes the workout array into json
    render :json => workouts.to_json
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:name, :user_id, :date, :time, :location, :category, :duration, :level, :description)
    end
end
