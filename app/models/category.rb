class Category < ActiveRecord::Base
	has_many :documents

	def initalize(attributes=nil)
	    attr_with_defaults = {:hidden => false}.merge(attributes)
	    super(attr_with_defaults)
	  end

	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end

	def hide
		self.update_attributes!(:hidden => true)
	end

	def show
		self.update_attributes!(:hidden => false)
	end
end