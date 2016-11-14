class Document < ActiveRecord::Base
    has_many :read_sessions
    has_many :users, through: :read_sessions
	belongs_to :category
	
	
# 	def set_all_unread()
#         this.delete_all()
#   end
	
end
