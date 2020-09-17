require 'spec_helper'

describe "Our Task Controller" do
  include SpecHelper

  before (:all) do
		@task = Task.create(
			name:    "my task", 
			minutes: 1,
			seconds: 0,
			rate:    20.00
		)
  end
  
  after (:all) do
		if !@task.destroyed?
			@task.delete	
		end
  end
  
  it "responds with a view titled 'Tasks' when we visit /tasks" do
    get("/tasks")
    expect(last_response.body.include?("Tasks")).to be(true)
  end
	
	it "displays a form for adding a task when we visit /tasks/new" do
    get "/tasks/new"
    expect(last_response.body).to include("<form ")
  end
  
  it "displays a page with the task name when we visit /tasks/edit/:id" do
    get("/tasks/edit/#{@task.id}")
    expect(last_response.body.include?("#{@task.name}")).to be(true)
  end  
  
  it "creates a task when we post to /tasks" do
    tasks_count = Task.all.count
    post("/tasks", { task: "test", minutes: 1, seconds: 0, rate: "$1.00" })
    expect(Task.all.count == tasks_count + 1).to eq(true)
		Task.find_by_name("test").delete
  end
  
  it "edits a task when we post to /tasks/edit" do
    new_task_name = "my task revised"
    post("/tasks/edit", { taskId: @task.id, task: new_task_name, minutes: @task.minutes, seconds: @task.seconds, rate: @task.rate })
    expect(@task.reload.name == new_task_name).to eq(true)
  end
  
  it "deletes a task when we post to /tasks/delete" do
    tasks_count = Task.all.count
    post("/tasks/delete", { taskId: @task.id })
    expect(Task.all.count == tasks_count - 1).to eq(true)
  end
end