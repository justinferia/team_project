class AlterColumnToWorkouts < ActiveRecord::Migration
  def change
    change_column :workouts, :level, :string
  end
end
