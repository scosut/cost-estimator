require 'spec_helper'

describe "Our Group Controller" do
  include SpecHelper

  before (:all) do
    @group = Group.create(name: "my group")
  end
  
  after (:all) do
    if !@group.destroyed?
      @group.delete
    end
  end
  
  it "responds with a view titled 'Groups' when we visit /groups" do
    get("/groups")
    expect(last_response.body.include?("Groups")).to be(true)
  end
	
	it "displays a form for adding a group when we visit /groups/new" do
    get "/groups/new"
    expect(last_response.body).to include("<form ")
  end
  
  it "displays a page with the group name when we visit /groups/edit/:id" do
    get("/groups/edit/#{@group.id}")
    expect(last_response.body.include?("#{@group.name}")).to be(true)
  end  
  
  it "creates a group when we post to /groups" do
    groups_count = Group.all.count
    post("/groups", { group: "test" })
    expect(Group.all.count == groups_count + 1).to eq(true)
		Group.find_by_name("test").delete
  end
  
  it "edits a group when we post to /groups/edit" do
    new_group_name = "my group revised"
    post("/groups/edit", { groupId: @group.id, group: new_group_name })
    expect(@group.reload.name == new_group_name).to eq(true)
  end
  
  it "deletes a group when we post to /groups/delete" do
    groups_count = Group.all.count
    post("/groups/delete", { groupId: @group.id })
    expect(Group.all.count == groups_count - 1).to eq(true)
  end
end