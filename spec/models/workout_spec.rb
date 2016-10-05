require 'rails_helper'

RSpec.describe Workout, :type => :model do
  it "is a thing" do
    expect{Workout.new}.to_not raise_error
  end
  #testing for relationship between workout and the user
  it "belongs to a user" do
    w = Workout.reflect_on_association(:user)
    w.macro == :belongs_to
  end
  #testing for validations on the workout form for name, location, category, duration, level, and description
  it "has a name that is not blank" do
    w = Workout.new(name: nil)
    expect(w.valid?).to be false
    expect(w.errors[:name].first).to eq "can't be blank"
  end
  it "has a location that is not blank" do
    w = Workout.new(location: nil)
    expect(w.valid?).to be false
    expect(w.errors[:location].first).to eq "can't be blank"
  end
  it "has a category that is not blank" do
    w = Workout.new(category: nil)
    expect(w.valid?).to be false
    expect(w.errors[:category].first).to eq "can't be blank"
  end
  it "has a duration that is not blank" do
    w = Workout.new(duration: nil)
    expect(w.valid?).to be false
    expect(w.errors[:duration].first).to eq "can't be blank"
  end
  it "has a level that is not blank" do
    w = Workout.new(level: nil)
    expect(w.valid?).to be false
    expect(w.errors[:level].first).to eq "can't be blank"
  end
  it "has a description that is not blank" do
    w = Workout.new(description: nil)
    expect(w.valid?).to be false
    expect(w.errors[:description].first).to eq "can't be blank"
  end

end #end of RSPEC
