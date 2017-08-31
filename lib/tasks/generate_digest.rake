require "#{Rails.root}/app/helpers/email_helper"
require 'date'
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
        @daily_records = MailRecord.where("created_at >= ? or updated_at >= ?", (@time - 24.hours), (@time - 24.hours))
        
        EmailHelper.generate(@daily_records, "daily")
        
        date = Date.new(@time.year, @time.month, @time.day)
        
        if date.monday?
            @weekly_records = MailRecord.where("created_at >= ? or updated_at >= ?", (@time - 7.days), (@time - 7.days))
            EmailHelper.generate(@weekly_records, "weekly")
            
            MailRecord.delete_all
        end
    end
    
    #below is code for testing/debugging
    
    #This task is used to check the mail_record list and make sure that they are updated and deleted accordingly
    task :list => :environment do
        record_count = 0
        MailRecord.all.each do |record|
            line = "Record #" + record.id.to_s + ": " + record.description + " || "
            if !record.committee.nil?
                line = line + "Committee " + record.committee.name + " || "
            end
            if !record.user.nil?
                line = line + "User " + record.user.name + " || "
            end
            if !record.category.nil?
                line = line + "Category " + record.category.name + " || "
            end
            if !record.announcement.nil?
                line = line + "Announcement " + record.announcement.title + " || "
            end
            if !record.document.nil?
                line = line + "Document " + record.document.title + " || "
            end
            if !record.meeting.nil?
                line = line + "Meeting " + record.meeting.name + " || "
            end
            line = line + "Created at: " + "#{record.created_at}"
            puts line
            record_count += 1
        end
        puts "Number of records: #{record_count}"
    end
    
    #this task is to test the date/time functions of rails
    task :check_date => :environment do
        @time = Time.now
        date = Date.new(@time.year, @time.month, @time.day)
        puts date.monday?
        puts date.tuesday?
        puts date.wednesday?
        puts date.thursday?
        puts date.friday?
        puts date.saturday?
        puts date.sunday?
    end
end
