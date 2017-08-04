class Committee < ActiveRecord::Base
	has_many :participations
	has_many :users, through: :participations
	has_many :documents
	has_many :announcements
	
	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end

	def hide
		self.update_attributes!(:hidden => true)
	end

	def show
		self.update_attributes!(:hidden => false)
	end

	def inactivate
		self.update_attributes!(:inactive => true)
	end

	def activate
		self.update_attributes!(:inactive => false)
	end

	def self.string_title
		"Committee"
	end
	
	def self.string_lower
		return "committee"
	end
end