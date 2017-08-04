class Category < ActiveRecord::Base
	has_many :documents, -> { order 'custom_order asc' }
	has_many :mail_records
	
	def initalize(attributes=nil)
	    attr_with_defaults = {:hidden => false}.merge(attributes)
	    super(attr_with_defaults)
	  end

	def self.has_name?(name)
		return self.where(name: "#{name}").length != 0
	end

	def self.order_by_name
		categories = self.order("name ASC").all
		categories.each_with_index do |category, i|
			category.update_attributes!(:custom_order => i)
		end
	end

	def self.update_category_order(id_order)
		id_order.each_with_index do |id, i|
			self.find(id).update_attributes(:custom_order => i)
		end
	end

	def hide
		self.update_attributes!(:hidden => true)
	end

	def show
		self.update_attributes!(:hidden => false)
	end
	
	
	def self.update_category_order(order)
		order.each_with_index do |id, i|
            self.find(id).update_columns(:custom_order => i)
        end
    end
    
    def self.sort_by_name
    	ordered_categories = self.order('name ASC').all
    	ordered_categories.each_with_index do |category, i|
    		category.update_columns(:custom_order => i)
    	end
    end
    
    def self.sort_docs(category, sort_by)
    	if sort_by == 'updated_at'
	    	docs = category.documents.reorder("#{sort_by} DESC")
	    else
	    	docs = category.documents.reorder("#{sort_by} ASC")
	    end
        docs.each_with_index do |doc, i|
            doc.update_columns(:custom_order => i)
        end
    end
    
	def self.string_title
		return "Category"
	end
	
	def self.string_lower
		return "category"
	end
	
end