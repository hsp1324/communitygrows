class Category < ActiveRecord::Base
	has_many :documents, -> { order 'custom_order asc' }

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
	
	def self.update_category_order(order)
		order.each_with_index do |id, i|
            self.find(id).update_attributes(:custom_order => i)
        end
    end
    
    def self.sort_by_name
    	self.order('name ASC').all
    end
end