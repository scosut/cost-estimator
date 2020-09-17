get "/calculate" do
  @groups = Group.joins(:materials).order("groups.name ASC, materials.name ASC").uniq
	@tasks  = Task.all.order(name: :asc)

  erb :"/calculate/index"
end