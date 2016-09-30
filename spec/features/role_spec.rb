require 'rails_helper'

RSpec.describe Role, :type => :model do
  it "is a thing" do
    expect{Role.new}.to_not raise_error
  end
  it "belongs to a user" do
    r = Role.reflect_on_association(:users)
    r.macro.should == :has_and_belongs_to_many
  end
end
