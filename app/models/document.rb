class Document < ActiveRecord::Base
    has_many :read_sessions
    has_many :users, through: :read_sessions
    has_one :mail_record, dependent: :destroy
	belongs_to :category
    belongs_to :committee	
	
    # def self.update_document_order(category_id, document_ids)
    #     if document_ids
    #         document_ids.each_with_index do |id, i|
    #             doc = self.find(id)
    #             doc.update_columns(:custom_order => i, :category_id => category_id)
    #         end
            
    #     end
    # end
	
end
