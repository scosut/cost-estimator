get "/tasks" do
  @tasks = Task.all.order(name: :asc)
  erb :"/tasks/index"
end

get "/tasks/new" do
  @task   = Task.new
	@errors = []
  erb :"/tasks/new"
end

get "/tasks/edit/:id" do
  @task   = Task.find(params[:id])
	@errors = []
	erb :"/tasks/edit"
end

post "/tasks" do
	@task = Task.new(
		name:    params[:task],
		minutes: params[:minutes], 
		seconds: params[:seconds],
		rate:    params[:rate].to_s.delete("$,")
	)
	@errors = Task.valid_input(@task)
	
	if (@errors.length == 0) then
		@task.save
		redirect "/tasks"
	else
    erb :"/tasks/new"
	end
end

post "/tasks/edit" do
	@task         = Task.find(params[:taskId])
	task_old      = @task.name
	@task.name    = params[:task]
  @task.minutes = params[:minutes]
  @task.seconds = params[:seconds]
	@task.rate    = params[:rate].to_s.delete("$,")
	@errors       = Task.valid_input(@task, task_old)
		
	if (@errors.length == 0) then
		@task.save
		redirect "/tasks"
	else
			erb :"/tasks/edit"
	end
end
	
post "/tasks/delete" do
	task = Task.find(params[:taskId])
	task.destroy
  redirect "/tasks"
end