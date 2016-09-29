require 'rails_helper'

RSpec.describe Workout, :type => :model do
  it "is a thing" do
    expect{Workout.new}.to_not raise_error
  end
  it "belongs to a user" do
    w = Workout.reflect_on_association(:user)
    w.macro == :belongs_to
  end
end
