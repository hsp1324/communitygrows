class Participation < ActiveRecord::Base
    belongs_to :committee
    belongs_to :user
end
