get "/materials" do
  @materials = Material.joins(:group).order("groups.name ASC, materials.name ASC").all
  erb :"/materials/index"
end

get "/materials/new" do
  @groups   = Group.all.order(name: :asc)
	@material = Material.new
	@group    = nil
	@newGroup = nil	
	@errors   = []
  erb :"/materials/new"
end

get "/materials/edit/:id" do
	@groups   = Group.all.order(name: :asc)
  @material = Material.find(params[:id])
	@group    = @material.group.id
	@newGroup = nil
	@errors   = []
  erb :"/materials/edit"
end

post "/materials" do
	@groups   = Group.all.order(name: :asc)
	@material = Material.new(
		name:     params[:material], 
		quantity: params.key?("quantity") ? params[:quantity] : nil, 
		cost:     params[:cost].to_s.delete("$,")
	)
	@group    = params[:group]
	@newGroup = params[:newGroup]
	@errors   = Group.valid_input(@group, @newGroup) + Material.valid_input(@material)
	
	if (@errors.length == 0) then
		if (@group == "new") then
			@group = Group.new(name: @newGroup)
			@group.save
		else
			@group = Group.find(@group)
		end

		@material.group_id = @group.id
		@material.save
			
		redirect "/materials"
	else
    erb :"/materials/new"
	end
end

post "/materials/edit" do
	@groups            = Group.all.order(name: :asc)	
	@material          = Material.find(params[:materialId])
	material_old       = @material.name
	@material.name     = params[:material]
  @material.quantity = params[:quantity]
  @material.cost     = params[:cost].to_s.delete("$,");
	@group             = params[:group]
	@newGroup          = params[:newGroup]
	@errors            = Group.valid_input(@group, @newGroup) + Material.valid_input(@material, material_old)
		
	if (@errors.length == 0) then
		if (@group == "new") then
			@group = Group.new(name: @newGroup)
			@group.save
		else
			@group = Group.find(@group)
		end
	
		@material.group_id = @group.id
		@material.save
	
		redirect "/materials"
	else
			erb :"/materials/edit"
	end
end
	
post "/materials/delete" do
	material = Material.find(params[:materialId])
	material.destroy
  redirect "/materials"
end