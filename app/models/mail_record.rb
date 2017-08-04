class MailRecord < ApplicationRecord
    belongs_to :committee
    belongs_to :category
    belongs_to :user
    belongs_to :announcement
    belongs_to :document
    belongs_to :meeting
end