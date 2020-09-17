class Task < ActiveRecord::Base
	def self.valid_input(task, task_old="")
		errors = []
		
    if (task.name.blank?) then
			errors << "Please provide the task."
		else
			if (task.name.downcase != task_old.downcase) then
				if (Task.find_by("LOWER(name)= ?", task.name.downcase).present?) then
					errors << "Task '#{task.name}' already exists."
				end
			end
		end
			
		if (task.minutes.blank?) then
			errors << "Please provide the minutes."
		else
			if (task.minutes > 59) then
				errors << "Minutes cannot exceed 59."
			end
		end
			
		if (task.seconds.blank?) then
			errors << "Please provide the seconds."
		else
			if (task.seconds > 59) then
				errors << "Seconds cannot exceed 59."
			end
		end
			
		if (task.rate.blank?) then
			errors << "Please provide the rate."
		end
			
		errors
  end
end