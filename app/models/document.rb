class Document < ActiveRecord::Base
    has_many :read_sessions
    has_many :users, through: :read_sessions
	belongs_to :category
	
	
    def self.update_document_order(category_id, document_ids)
        # cat = Category.find(category_id)
        if document_ids
            document_ids.each_with_index do |id, i|
                doc = self.find(id)
                doc.update_attributes(:custom_order => i, :category_id => category_id)
            end
        end
    end
	
end
