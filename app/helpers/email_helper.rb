module EmailHelper
    def send_simple_mail(content, type)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                if type == "meeting"
                    NotificationMailer.meeting_email(user, content).deliver
                elsif type == "Mupdate"
                    NotificationMailer.meeting_update_email(user, content).deliver
                elsif content.committee.nil? or user.committees.include? content.committee
                    if type == "announcement"
                        NotificationMailer.announcement_email(user, content).deliver
                    elsif type == "Aupdate"
                        NotificationMailer.announcement_update_email(user, content).deliver
                    elsif type == "document"
                        NotificationMailer.document_email(user, content).deliver
                    elsif type == "Dupdate"
                        NotificationMailer.document_update_email(user, content).deliver
                    elsif type == "emergency"
                        NotificationMailer.emergency_email(user, content).deliver
                    end
                end
            end
        end
    end
    
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
        send_simple_mail(announcement, "announcement")
    end
    
    def send_emergency_announcement_email (announcement)
        send_simple_mail(announcement, "emergency")
    end
    
    def send_announcement_update_email(announcement)
        send_simple_mail(announcement, "Aupdate")
    end

    def send_document_email(document)
        send_simple_mail(document, "document")
    end

    def send_document_update_email(document)
        send_simple_mail(document, "Dupdate")
    end
    
    def send_document_transfer_email(document)
        User.all.each do |user|
            if user.digest_pref == "real_time"
                NotificationMailer.document_transfer_email(user, document).deliver
            end
        end
    end
    
    def send_meeting_email(meeting)
        send_simple_mail(meeting, "meeting")
    end
    
    def send_meeting_update_email(meeting)
        send_simple_mail(meeting, "Mupdate")
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
        @text = "<p><strong><style='font-size:14px'>Meetings:</strong><style='font-size:12px'><br><br>"
        @stuff = false
        @records.each do |record|
            if @stuff
                @tmptext += "<br><br>"
            end
            @stuff = true
            @text += "<strong>&emsp; "
            @text = @text + record.meeting.name + " " + record.description + "d" #created, updated, need the d at the end
            @text += "</strong><br>"
            
            @text += "&emsp; "
            @text = @text + record.meeting.time + record.meeting.date + " at " + record.meeting.location
            @text += "<br>"
            
            @text += "&emsp; "
            @text += record.meeting.description
        end
        if @stuff
            return "<br><br><hr>" + @text + "<br><br><hr>"
        end
        return "<br><br><hr>"
    end
    
    def compile_announcements(title, records)
        @title = title
        @records = records
        @stuff = false
        @text = "<strong><style='font-size:14px'>" + @title + " Announcements:<style='font-size:12px'></strong><br><br>"

        @records.each do |record|
            if @stuff
                @text += "<br><br>"
            end
            @committee = record.committee
            @stuff = true
            @text += "<strong>&emsp; "
            @text += record.announcement.title
            @text += "<br></strong>"
            
            @text += "&emsp; "
            @text += record.announcement.content
        end
        
        if @stuff
            if @committee.nil?
                return "<br><br><hr>" + @text
            end
            return "<br><br><hr class='style10'>" + @text
        end
        return ""
    end
    
    def compile_documents(title, records)
        @title = title
        @records = records
        @stuff = false
        
        @text = "<strong><style='font-size:14px'>" + @title + " Documents:<style='font-size:12px'></strong><br><br>"
        
        @records.each do |record|
            if @stuff
                @text += "<br><br>"
            end
            @category = record.category
            @stuff = true
            @text += '&emsp;&emsp; <a href = "'
            @text += record.document.url
            @text += '">'
            @text += record.document.title
            @text += '</a>'
            if @category
                @text = @text + " in the " + record.category.name + " Category"
            end
            if record.description != 'transfer'
                @text = @text + ' was ' + record.description + 'd.'
            else
                @text += ' was transferred.'
            end
            
        end
        
        if @stuff
            if @category
                return "<br><br><hr>" + @text
            end
            return "<br><br><hr class='style10'>" + @text
        end
        return ""
    end
    
    def compile_committee_records(title, records)
        @records = records
        @title = title
        @text = ''
        header = "<style='font-size:14px'>"
        footer = "<style='font-size:12px'><br>"
        
        name_change = @records.find_by("description LIKE ?", 'name%')
        if name_change
            old_name = name_change.description.split(" ")[1]
            @text += header + "The " + old_name + " Committee had its name changed to " + name_change.committee.name + "." + footer
        end
        
        description_change = @records.find_by(description: "description")
        if description_change
            @text += header + "The " + description_change.committee.name + " Committee had its description changed to:" + footer + name_change.committee.description + ".<br><br>"
        end
        
        @stuff = false
        @tmptext = "<strong><style='font-size:14px'> The following members have joined " + title + " Committee:<style='font-size:12px'></strong><br>"
        @records.where.not(user_id: nil).each do |record|
            if @stuff
                @tmptext += "<br>"
            end
            @stuff = true
            @tmptext = @tmptext + "&emsp; " + record.user.name
        end
        if @stuff
            @text += @tmptext
        end
        
        @text += self.compile_announcements(@title, records.where.not(announcement_id: nil))
        @text += self.compile_documents(@title, records.where.not(document_id: nil))
        
        if @text == ""
            return ""
        end
        return "<p><style='font-size:14px'><strong>Committee " + title + " Updates</strong><style='font-size:12px'><br>" + @text + "</p>"
    end
    
    def generate(records, time_period)
        @records = records
        if time_period == "daily"
            @subject = "Daily Digest for " + (Time.now - 24.hours).strftime("%m/%d")
            @main_text = "Here is what has happened on Community Grows in the past 24 hours:"
        else
            @subject = "Weekly Digest for " + Time.now.strftime("%m/%d")
            @main_text = "Here is what has happened on Community Grows in the past 7 days:"
        end

        @main_text += self.compile_announcements("Main", @records.where(committee_id: nil).where.not(announcement_id: nil))
        @records = records
        @main_text += self.compile_documents("Category", @records.where.not(category_id: nil))
        @records = records
        @main_text += self.compile_meetings(@records.where.not(meeting_id: nil))
        
        #compile committee related announcements, documents and member details
        User.all.each do |user|
            if user.digest_pref == time_period
                committee_list = ""
                @stuff = false
                user.committees.each do |com|
                    if @stuff
                        committee_list += ", "
                    end
                    @stuff = true
                    committee_list += com.name
                end
                
                @content = "This is your " + time_period + " digest. You can adjust your digest frequency in your account settings."
                if @stuff
                    @content += " You are currently a member of and receiving notifications from the following committees:<br><br>&emsp; " + committee_list + "<br><br>"
                end
                
                @content += @main_text
                
                Committee.all.each do |committee|
                    @records = records
                    #if Participation.find_by(user_id: user.id, committee_id: committee.id)
                    if user.committees.include? committee
                        @committee_text = self.compile_committee_records(committee.name, @records.where(committee_id: committee.id))
                        if @committee_text != ""
                            @content += @committee_text + "<br><br><hr>"
                        end
                    end
                end
                
                puts(@content)
                NotificationMailer.digest_email(user, @subject, @content).deliver
            end
        end
    end
end
