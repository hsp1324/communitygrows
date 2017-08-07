module EmailHelper
    def send_member_email(committee, user_list)
        new_users = ""
        user_list.each do |id|
            new_users = new_users + User.find(id).name + "<br>"
        end
        
        User.all.each do |user|
            if user.committees.include? committee
                if user.digest_pref == "real_time"
                    NotificationMailer.member_email(committee, user, new_users).deliver
                end
            end
        end
    end
    
    def send_announcement_email(announcement)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if announcement.committee.nil? or user.committees.include? announcement.committee
                    NotificationMailer.announcement_email(user, announcement).deliver
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
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if announcement.committee.nil? or user.committees.include? announcement.committee
                    NotificationMailer.announcement_update_email(user, announcement).deliver
                end
            end
        end
    end

    def send_document_email(document)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if document.committee.nil? or user.committees.include? document.committee
                    NotificationMailer.document_email(user, document).deliver
                end
            end
        end
    end

    def send_document_update_email(document)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if document.committee.nil? or user.committees.include? document.committee
                    NotificationMailer.document_update_email(user, document).deliver
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
    
    def send_committee_update_email(committee, old_name, name, description)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if user.committees.include? committee
                    NotificationMailer.committee_update_email(user, old_name, name, description).deliver
                end
            end
        end
    end
    
    def send_committee_name_update_email(committee, old_name, name)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if user.committees.include? committee
                    NotificationMailer.committee_name_update_email(user, old_name, name).deliver
                end
            end
        end
    end
    
    def send_committee_description_update_email(committee, description)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if user.committees.include? committee
                    NotificationMailer.committee_description_update_email(user, committee.name, description).deliver
                end
            end
        end
    end
    
    def compile_meetings(records)
        @records = records
        @text = "<p><strong><style='font-size:14px'>Meetings:</strong><style='font-size:12px'><br>"
        @stuff = false
        @records.each do |record|
            @stuff = true
            @text += "<strong>&emsp; "
            @text = @tmp_text + record.meeting.name + " " + record.description + "d" #created, updated, need the d at the end
            @text += "</strong><br>"
            
            @text += "&emsp;&emsp; "
            @text = @tmp_text + record.meeting.time + record.meeting.date + " at " + record.meeting.location
            @text += "<br>"
            
            @text += "&emsp;&emsp; "
            @text += record.meeting.description
            @text += "<br>"
        end
        if @stuff
            return @text
        end
        return ""
    end
    
    def compile_announcements(title, records)
        @title = title
        @records = records
        @stuff = false
        @tmptext = "<strong><style='font-size:14px'>" + @title + " Announcements:<style='font-size:12px'></strong><br>"

        @records.each do |record|
            @stuff = true
            @tmptext += "<strong>&emsp; "
            @tmptext += record.announcement.title
            @tmptext += "</strong><br>"
            
            @tmptext += "&emsp;&emsp; "
            @tmptext += record.announcement.content
            @tmptext += "<br>"
        end
        
        if @stuff
            return @tmptext
        end
        return ""
    end
    
    def compile_documents(title, records)
        @title = title
        @records = records
        @stuff = false
        
        @text = "<strong><style='font-size:14px'>" + @title + " Documents:<style='font-size:12px'></strong><br>"
        
        @records.each do |record|
            @stuff = true
            @text += '&emsp;&emsp; <a href = "'
            @text += record.document.url
            @text += '">'
            @text += record.document.title
            @text += '</a>'
            if title == "Category"
                @text = @text + " in the " + record.category.name + " Category"
            end
            if record.description != 'transfer'
                @tmptext = @tmptext + ' was ' + record.description + 'd.'
            else
                @tmptext += ' was transferred.'
            end
            @tmptext += '<br>'
        end
        
        if @stuff
            return @text
        end
        return ""
    end
    
    def compile_committee_records(title, records)
        @records = records
        @title = title
        @text = '<p>'
        header = "<strong><style='font-size:14px'>"
        footer = ".<style='font-size:12px'></strong><br>"
        
        name_change = @records.find_by("description LIKE ?", 'name%')
        if name_change
            old_name = name_change.description.split(" ")[1]
            @text = @text + header + "The " + old_name + " Committee had its name changed to " + name_change.committee.name + "." + footer
        end
        
        description_change = @records.find_by(description: "description")
        if description_change
            @text += @text + header + "The " + description_change.committee.name + " Committee had its description changed to:" + footer + name_change.committee.description + ".<br>"
        end
        
        @stuff = false
        @tmptext = "<strong><style='font-size:14px'> The following members have joined " + title + " Committee:<style='font-size:12px'></strong><br>"
        @records.where.not(user_id: nil).each do |record|
            @stuff = true
            @tmptext = @tmptext + "&emsp; " + record.user.name + "<br>"
        end
        if @stuff
            @text += @tmptext
        end
        
        @text += self.compile_announcements(@title, records.where.not(announcement_id: nil))
        @text += self.compile_documents(@title, records.where.not(document_id: nil))
        
        if @text == "<p>"
            return ""
        end
        return @text + "</p>"
    end
    
    def generate(records, time_period)
        @records = records
        @subject = time_period + " Digest for " + Time.now.strftime("%m/%d")
        
        @main_text = self.compile_meetings(@records.where.not(meeting_id: nil))
        @main_text += self.compile_announcements("Main", @records.where(committee_id: nil).where.not(announcement_id: nil))
        @main_text += self.compile_documents("Category", @records.where.not(category_id: nil))

        #compile committee related announcements, documents and member details
        User.all.each do |user|
            if user.digest_pref == time_period
                @content = @main_text
                
                Committee.all.each do |committee|
                    @records = records
                    #if Participation.find_by(user_id: user.id, committee_id: committee.id)
                    if user.committees.include? committee
                        @committee_text = self.compile_committee_records(committee.name, @records.where(committee_id: committee.id))
                        @content += @committee_text
                    end
                end
                
                puts(@content)
                
                NotificationMailer.digest_email(user, @subject, @content).deliver
            end
        end
    end
end
