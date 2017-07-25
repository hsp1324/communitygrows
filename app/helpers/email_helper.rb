module EmailHelper
    def send_announcement_email(committee, announcement)
        if committee == ""
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.announcement_email(user, announcement).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    puts "HI1"
                    if Participation.find_by(committee_id: committee.id, user_id: user.id)
                        puts "HI2"
                        NotificationMailer.announcement_email(user, announcement).deliver
                    end
                end
            end
        end
    end

    def send_announcement_update_email(committee, announcement)
        if committee == ""
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.announcement_update_email(user, announcement).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if Participation.find_by(committee_id: committee, user_id: user.id)
                        NotificationMailer.announcement_update_email(user, announcement).deliver
                    end
                end
            end
        end
    end

    def send_document_email(committee, document)
        if committee == ""
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.document_email(user, document).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if Participation.find_by(committee_id: committee.id, user_id: user.id)
                        NotificationMailer.document_email(user, document).deliver
                    end
                end
            end
        end
    end

    def send_document_update_email(committee, document)
        if committee == ""
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.document_update_email(user, document).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if Participation.find_by(committee_id: committee, user_id: user.id)
                        NotificationMailer.document_update_email(user, document).deliver
                    end
                end
            end
        end
    end

    def compile_announcements_and_documents(title, committee, records)
        @records = records
        @committee = committee
        @title = title
        
        @text = ''
        
        @stuff = false
        @tmptext = "<p><strong><font size='+2'>" + @title + " Announcements:<font size='+1'></strong></p>"
        
        @records.where(record_type: 'announcement', committee: @committee).each do |record|
            @stuff = true
            @tmptext += "<p><strong>&emsp; "
            @tmptext += Announcement.find(record.record_id).title
            @tmptext += "</strong></p>"
            
            @tmptext += "<p>&emsp;&emsp; "
            @tmptext += Announcement.find(record.record_id).content
            @tmptext += "</p>"
        end
        
        if @stuff
            @text += @tmptext
        end
        
        @stuff = false
        @tmptext = "<p><strong><font size='+2'>" + @title + " Documents:<font size='+1'></strong></p>"
        
        @records.where(record_type: 'document', committee: @committee).each do |record|
            @stuff = true
            @tmptext += '<p>&emsp;&emsp; <a href = "'
            @tmptext += Document.find(record.record_id).url
            @tmptext += '">'
            @tmptext += Document.find(record.record_id).title
            @tmptext += '</a></p>'
        end
        
        if @stuff
            @text += @tmptext
        end
        return @text
    end
    
    def generate(records, time_period)
        @records = records
        @subject = time_period + " Digest for " + Time.now.strftime("%m/%d")
        
        @main_text = self.compile_announcements_and_documents("Main", "", @records)
        
        User.all.each do |user|
            if user.digest_pref == "daily"
                @content = @main_text
                
                Committee.all.each do |committee|
                    if Participation.find_by(committee_id: committee.id, user_id: user.id)
                        @committee_text = self.compile_announcements_and_documents(committee.name, committee.name, @records)
                        @content += @committee_text
                    end
                end
                
                puts(@content)
                
                #NotificationMailer.digest_email(user, @subject, @content)
            end
        end
    end
        
end
