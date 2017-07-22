class Committee < ActiveRecord::Base
	
	has_many :users, through: :participations
	
	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end
end