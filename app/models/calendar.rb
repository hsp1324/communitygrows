class Calendar < ApplicationRecord
    def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end
	
    def hide
		self.update_attributes!(:hidden => true)
	end

	def show
		self.update_attributes!(:hidden => false)
	end
	
	def self.string_title
		"Calendar"
	end
	
	def self.string_lower
		"calendar"
	end
	
end
