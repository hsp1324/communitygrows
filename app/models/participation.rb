class Participation < ApplicationRecord
    belongs_to :committee
    belongs_to :user
end
