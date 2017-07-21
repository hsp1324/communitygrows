class Commitee < ActiveRecord::Base

	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end
end