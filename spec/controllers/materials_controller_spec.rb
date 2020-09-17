require 'spec_helper'

describe "Our Material Controller" do
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
  
  it "responds with a view titled 'Materials' when we visit /materials" do
    get("/materials")
    expect(last_response.body.include?("Materials")).to be(true)
  end
	
	it "displays a form for adding a material when we visit /materials/new" do
    get "/materials/new"
    expect(last_response.body).to include("<form ")
  end
  
  it "displays a page with the material name when we visit /materials/edit/:id" do
    get("/materials/edit/#{@material.id}")
    expect(last_response.body.include?("#{@material.name}")).to be(true)
  end  
  
  it "creates a material when we post to /materials" do
    materials_count = Material.all.count
    post("/materials", { group: "new", newGroup: "test", material: "test", quantity: "no", cost: "$1.00" })
    expect(Material.all.count == materials_count + 1).to eq(true)
		Material.find_by_name("test").delete
		Group.find_by_name("test").delete
  end
  
  it "edits a material when we post to /materials/edit" do
    new_material_name = "my material revised"
    post("/materials/edit", { group: @group.id, newGroup: nil, materialId: @material.id, material: new_material_name, quantity: @material.quantity, cost: @material.cost })
    expect(@material.reload.name == new_material_name).to eq(true)
  end
  
  it "deletes a material when we post to /materials/delete" do
    materials_count = Material.all.count
    post("/materials/delete", { materialId: @material.id })
    expect(Material.all.count == materials_count - 1).to eq(true)
  end
end