class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :instructor
      t.date :date
      t.time :time
      t.string :location
      t.string :category
      t.float :price
      t.string :duration
      t.integer :level
      t.text :description

      t.timestamps null: false
    end
  end
end
