require 'rails_helper'

RSpec.describe User, type: :model do
  it "is a thing" do
    expect{User.new}.to_not raise_error
  end
  it "has a role" do
    u = User.reflect_on_association(:roles)
    u.macro.should == :has_and_belongs_to_many
  end
end
