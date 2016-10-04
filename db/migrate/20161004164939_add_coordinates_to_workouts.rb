class AddCoordinatesToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :latitude, :float
    add_column :workouts, :longitude, :float
  end
end
