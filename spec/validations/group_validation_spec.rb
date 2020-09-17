require 'spec_helper'

describe "Our Group Validation Methods" do
  include SpecHelper

  before (:all) do
    @group = Group.create(name: "my group")
  end
  
  after (:all) do
    if !@group.destroyed?
      @group.delete
    end
  end

  it "prevents a group from being added without a name" do
		group = Group.new(name: nil)
    error = Group.check_input(group)
    expect(error.include?("Please provide a group.")).to be(true)
  end
	
	it "prevents a group from being added with a name that already exists" do
		group = Group.new(name: "my group")
    error = Group.check_input(group)
    expect(error.include?("Group '#{group.name}' already exists.")).to be(true)
  end
end