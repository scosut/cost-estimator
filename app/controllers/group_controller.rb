get "/groups" do
  @groups   = Group.all.order(name: :asc)
	erb :"/groups/index"
end

get "/groups/new" do
	@group = Group.new
	@errors   = []
  erb :"/groups/new"
end

get "/groups/edit/:id" do
  @group = Group.find(params[:id])
	@errors   = []
  erb :"/groups/edit"
end

post "/groups" do
	@group = Group.new(
		name: params[:group] 
	)
	@errors = Group.check_input(@group)
	
	if (@errors.length == 0) then
		@group.save
			
		redirect "/groups"
	else
    erb :"/groups/new"
	end
end

post "/groups/edit" do
	@group      = Group.find(params[:groupId])
	group_old   = @group.name
	@group.name = params[:group]
	@errors     = Group.check_input(@group, group_old)
		
	if (@errors.length == 0) then
		@group.save
	
		redirect "/groups"
	else
			erb :"/groups/edit"
	end
end
	
post "/groups/delete" do
	group = Group.find(params[:groupId])
	group.destroy
  redirect "/groups"
end