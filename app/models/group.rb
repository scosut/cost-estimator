class Group < ActiveRecord::Base
	has_many :materials
	
	def self.check_input(group, group_old="")
		errors = []
		
    if (group.name.blank?) then
			errors << "Please provide a group."
		else
			if (group.name.downcase != group_old.downcase) then
				if (Group.find_by("LOWER(name)= ?", group.name.downcase).present?) then
					errors << "Group '#{group.name}' already exists."
				end
			end
		end
			
		errors
  end
	
	def self.valid_input(group, newGroup)
		errors = []
		
    if (group.blank?) then
			errors << "Please select a group."
		end
			
		if (group == "new") then
			if (newGroup.blank?) then
				errors << "Please provide the new group."
			else
				if (Group.find_by("LOWER(name)= ?", newGroup.downcase).present?) then
					errors << "Group '#{newGroup}' already exists."
				end
			end
		end
			
		errors
  end
end