module EmailHelper
    def send_member_email(committee, new_user)
        User.all.each do |user|
            if user.committees.include? committee
                if user.digest_pref == "real_time"
                    NotificationMailer.member_email(committee, user, new_user).deliver
                end
            end
        end
    end
    
    def send_announcement_email(announcement)
        if announcement.committee == nil
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.announcement_email(user, announcement).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if user.committees.include? announcement.committee
                        NotificationMailer.announcement_email(user, announcement).deliver
                    end
                end
            end
        end
    end
    
    def send_emergency_announcement_email (announcement)
        User.all.each do |user|
            NotificationMailer.emergency_email(user, announcement).deliver
        end
    end
    
    def send_announcement_update_email(announcement)
        if announcement.committee == nil?
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.announcement_update_email(user, announcement).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if user.committees.include? announcement.committee
                        NotificationMailer.announcement_update_email(user, announcement).deliver
                    end
                end
            end
        end
    end

    def send_document_email(document)
        if document.committee == nil
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.document_email(user, document).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if user.committees.include? document.committee
                        NotificationMailer.document_email(user, document).deliver
                    end
                end
            end
        end
    end

    def send_document_update_email(document)
        if document.committee == nil
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    NotificationMailer.document_update_email(user, document).deliver
                end
            end
        else
            User.all.each do |user|
                if user.digest_pref == "real_time"
                    if user.committees.include? document.committee
                        NotificationMailer.document_update_email(user, document).deliver
                    end
                end
            end
        end
    end
    
    def send_document_transfer_email(document)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                NotificationMailer.document_transfer_email(user, document).deliver
            end
        end
    end
    
    def send_meeting_email(meeting)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                NotificationMailer.meeting_email(user, meeting).deliver
            end
        end
    end
    
    def send_meeting_update_email(meeting)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                NotificationMailer.meeting_update_email(user, meeting).deliver
            end
        end
    end
    
    def compile_announcements_and_documents(title, records)
        @records = records
        @title = title
        
        @text = ''
        
        @stuff = false
        @tmptext = "<p><strong><font size='+2'>" + @title + " Announcements:<font size='+1'></strong><br>"

        @records.where.not(announcement_id: nil).each do |record|
            @stuff = true
            @tmptext += "<strong>&emsp; "
            @tmptext += record.announcement.title
            @tmptext += "</strong><br>"
            
            @tmptext += "&emsp;&emsp; "
            @tmptext += record.announcement.content
            @tmptext += "<br>"
        end
        
        if @stuff
            @text += @tmptext
        end
    
        @stuff = false
    
        #Document
        @tmptext = "<strong><font size='+2'>" + @title + " Documents:<font size='+1'></strong><br>"
        
        @records.where.not(document_id: nil).each do |record|
            @stuff = true
            @tmptext += '&emsp;&emsp; <a href = "'
            @tmptext += record.document.url
            @tmptext += '">'
            @tmptext += record.document.title
            @tmptext += '</a>'
            if record.description != 'transfer'
                @tmptext = @tmptext + ' was ' + record.description + 'd.'
            else
                @tmptext += ' was transferred.'
            end
            @tmptext += '<br>'
        end
        
        if @stuff
            @text += @tmptext + '</p>'
        end
        return @text
    end
    
    def generate(records, time_period)
        @records = records
        @subject = time_period + " Digest for " + Time.now.strftime("%m/%d")
        
        @main_text = ""
        
        #compile meetings section of digest
        @tmp_text = "<p><strong><font size='+2'>Meetings:</strong><font size='+1'><br>"
        @stuff = false
        @records.where.not(meeting_id: nil).each do |record|
            @stuff = true
            @tmp_text += "<strong>&emsp; "
            @tmp_text = @tmp_text + record.meeting.name + " " + record.description + "d" #created, updated, need the d at the end
            @tmp_text += "</strong><br>"
            
            @tmp_text += "&emsp;&emsp; "
            @tmp_text = @tmp_text + record.meeting.time + record.meeting.date + " at " + record.meeting.location
            @tmp_text += "<br>"
            
            @tmp_text += "&emsp;&emsp; "
            @tmp_text += record.meeting.description
            @tmp_text += "<br>"
        end
        
        if @stuff
            @main_text += @tmp_text + "</p>"
        end
        
        #compile main announcements
        @stuff = false
        @tmptext = "<p><strong><font size='+2'>Main Announcements:<font size='+1'></strong><br>"

        @records.where(committee_id: nil).where.not(announcement_id: nil).each do |record|
            @stuff = true
            @tmptext += "<strong>&emsp; "
            @tmptext += record.announcement.title
            @tmptext += "</strong><br>"
            
            @tmptext += "&emsp;&emsp; "
            @tmptext += record.announcement.content
            @tmptext += "<br>"
        end
        
        if @stuff
            @main_text += @tmptext
        end
    
        #compile category documents
        @stuff = false
        @tmptext = "<strong><font size='+2'>Category Documents:<font size='+1'></strong><br>"
        
        @records.where.not(category_id: nil).each do |record|
            @stuff = true
            @tmptext += '&emsp;&emsp; <a href = "'
            @tmptext += record.document.url
            @tmptext += '">'
            @tmptext += record.document.title
            @tmptext += '</a>'
            if record.description != 'transfer'
                @tmptext = @tmptext + ' was ' + record.description + 'd in ' + record.category.name + "." 
            else
                @tmptext = @tmptext + ' was transferred from ' + record.committee.name + ' to ' + record.category.name + "."
            end
            @tmptext += '<br>'
        end
        
        if @stuff
            @main_text += @tmptext
        end

        #compile committee related announcements, documents and member details
        User.all.each do |user|
            if user.digest_pref == time_period
                @content = @main_text
                
                Committee.all.each do |committee|
                    @records = records
                    #if Participation.find_by(user_id: user.id, committee_id: committee.id)
                    if user.committees.include? committee
                        @committee_text = self.compile_announcements_and_documents(committee.name, @records.where(committee_id: committee.id))
                        @content += @committee_text
                    end
                end
                
                puts(@content)
                puts user.name
                puts user.email
                
                NotificationMailer.daily_digest_email(user, @subject, @content).deliver
            end
        end
    end
        
end
