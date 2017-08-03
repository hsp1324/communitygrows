class Announcement < ActiveRecord::Base
    has_many :comments
    #belong to committee
end
