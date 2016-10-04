class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :get_workouts, :search]
  # GET /workouts
  # GET /workouts.json
  def index
    @workouts = Workout.all
  end

  def search
      if (params[:search1].nil? || params[:search1].strip.empty?) && (params[:search2].nil? || params[:search2].strip.empty?)
        @workouts = Workout.all
      elsif
      params[:search2].nil? || params[:search2].strip.empty?
        @workouts = Workout.search(params[:search1])
      elsif
      params[:search1].nil? || params[:search1].strip.empty?
        @workouts = Workout.search(params[:search2])
      else
        @workouts = Workout.search(params[:search1])
        @workouts = @workouts.search(params[:search2])
      end
      render :index
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
  end

  # GET /workouts/new
  def new
    if !current_user.has_role? :instructor
      flash[:alert] = 'You must be an instructor to create a workout'
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

  def get_workouts
    @workouts = Workout.all
    workouts = []
    @workouts.each do |workout|
      # value ? a : b means if value is true, do a.  If value is false, do b. (inline if statement)
      user = workout.user.present? ? workout.user.name : nil
      image = workout.user.present? ? workout.user.image.url : nil
      workouts << { id: workout.id, title: workout.name, start:DateTime.new(workout.date.year, workout.date.month, workout.date.day, workout.time.hour, workout.time.min, workout.time.sec).to_s, instructor:  user, description:workout.description, location: workout.location, date:workout.date, category: workout.category, price: workout.price, duration: workout.duration, level:workout.level, time:workout.time.strftime('%r'), image: workout.user.image.url
      }
    end
    render :json => workouts.to_json
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:name, :user_id, :date, :time, :location, :category, :price, :duration, :level, :description)
    end
end
