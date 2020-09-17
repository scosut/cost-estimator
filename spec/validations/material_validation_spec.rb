require 'spec_helper'

describe "Our Material Validation Methods" do
  include SpecHelper

  before (:all) do
		@group    = Group.create(name: "my group")
    @material = @group.materials.create(
			name:     "my material", 
			quantity: "no", 
			cost:     1.00
		)
  end
  
  after (:all) do
		if !@material.destroyed?
			@material.delete	
		end
		
		if !@group.destroyed?		
			@group.delete
		end		
  end

  it "prevents a material from being added without selecting a group" do
    error = Group.valid_input(nil, nil)
    expect(error.include?("Please select a group.")).to be(true)
  end
	
	it "prevents a material from being added without providing the new group" do
    error = Group.valid_input("new", nil)
    expect(error.include?("Please provide the new group.")).to be(true)
  end
	
	it "prevents a material from being added with a new group that already exists" do
    error = Group.valid_input("new", "my group")
    expect(error.include?("Group 'my group' already exists.")).to be(true)
  end
	
	it "prevents a material from being added without a name" do
		material = Material.new(name: nil)
    error = Material.valid_input(material)
    expect(error.include?("Please provide the material.")).to be(true)
  end
	
	it "prevents a material from being added with a name that already exists" do
    material = Material.new(name: "my material")
		error = Material.valid_input(material)
    expect(error.include?("Material '#{material.name}' already exists.")).to be(true)
  end
	
	it "prevents a material from being added without a quantity" do
		material = Material.new(name: "test", quantity: nil)
    error = Material.valid_input(material)
    expect(error.include?("Please indicate if quantity is required.")).to be(true)
  end
	
	it "prevents a material from being added without a cost" do
		material = Material.new(name: "test", cost: nil)
    error = Material.valid_input(material)
    expect(error.include?("Please provide the cost.")).to be(true)
  end
end