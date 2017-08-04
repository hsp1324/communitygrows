class Meeting < ActiveRecord::Base
	has_one :mail_record, dependent: :destroy
	
	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end

	def self.string_title
		"Meeting"
	end
	
	def self.string_lower
		return "meeting"
	end
end