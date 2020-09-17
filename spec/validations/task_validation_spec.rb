require 'spec_helper'

describe "Our Task Validation Methods" do
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

	it "prevents a task from being added without a name" do
		task  = Task.new(name: nil)
    error = Task.valid_input(task)
    expect(error.include?("Please provide the task.")).to be(true)
  end
	
	it "prevents a task from being added with a name that already exists" do
    task  = Task.new(name: "my task")
		error = Task.valid_input(task)
    expect(error.include?("Task '#{task.name}' already exists.")).to be(true)
  end
	
	it "prevents a task from being added without the minutes" do
		task  = Task.new(name: "test", minutes: nil)
    error = Task.valid_input(task)
    expect(error.include?("Please provide the minutes.")).to be(true)
  end
	
	it "prevents a task from being added without the seconds" do
		task  = Task.new(name: "test", seconds: nil)
    error = Task.valid_input(task)
    expect(error.include?("Please provide the seconds.")).to be(true)
  end
	
	it "prevents a task from being added without the rate" do
		task =  Task.new(name: "test", rate: nil)
    error = Task.valid_input(task)
    expect(error.include?("Please provide the rate.")).to be(true)
  end
end