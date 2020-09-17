class Material < ActiveRecord::Base
	belongs_to :group
	
	def self.valid_input(material, material_old="")
		errors = []
		
    if (material.name.blank?) then
			errors << "Please provide the material."
		else
			if (material.name.downcase != material_old.downcase) then
				if (Material.find_by("LOWER(name)= ?", material.name.downcase).present?) then
					errors << "Material '#{material.name}' already exists."
				end
			end
		end
			
		if (material.quantity.blank?) then
			errors << "Please indicate if quantity is required."
		end
			
		if (material.cost.blank?) then
			errors << "Please provide the cost."
		end
			
		errors
  end
end