require "#{Rails.root}/app/helpers/email_helper"
include EmailHelper

namespace :generate_digest do
    task :daily => :environment do
        @records = MailRecord.where("created_at >= ? or updated_at >= ?", (Time.now - 24.hours), (Time.now - 24.hours))
        
        EmailHelper.generate_daily(@records)
    end
end
