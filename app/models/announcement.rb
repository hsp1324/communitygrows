class Announcement < ActiveRecord::Base
    has_many :comments
    has_one :mail_record, dependent: :destroy
    belongs_to :committee
end
