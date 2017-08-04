require "#{Rails.root}/app/helpers/email_helper"
include EmailHelper

namespace :generate_digest do
    task :daily => :environment do
        @records = MailRecord.where("created_at >= ? or updated_at >= ?", (Time.now - 24.hours), (Time.now - 24.hours))
        
        EmailHelper.generate(@records, "daily")
    end
    
    task :weekly => :environment do
        #select records within a week and some buffer time to account for run time of :daily, which will be called before :weekly
        @records = MailRecord.where("created_at >= ? or updated_at >= ?", (Time.now - 7.days), (Time.now - 7.days))
        
        EmailHelper.generate(@records, "weekly")
    end
    
    task :clean => :environment do
        MailRecord.delete_all
    end
    
    task :scheduled_digest => :environment do
        @time = Time.now
        @weekly_records = MailRecord.where("created_at >= ? or updated_at >= ?", (@time - 7.days), (@time - 7.days))
        @daily_records = MailRecord.where("created_at >= ? or updated_at >= ?", (@time - 24.hours), (@time - 24.hours))
        
        EmailHelper.generate(@daily_records, "Daily")
        EmailHelper.generate(@weekly_records, "Weekly")
        
        MailRecord.delete_all
    end
    
end
