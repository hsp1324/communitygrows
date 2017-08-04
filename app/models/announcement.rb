class Announcement < ActiveRecord::Base
    has_many :comments
    belongs_to :committee
end
