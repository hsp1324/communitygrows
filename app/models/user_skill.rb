class UserSkill < ApplicationRecord
    belongs_to :user
    belongs_to :expertise
end
