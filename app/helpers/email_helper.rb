module EmailHelper
    def send_doccom_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver
                end
            end
        end
    end

    def send_doccom_update_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
                end
            end
        end
    end
    def send_doc_email(file)
        User.all.each do |user|
            # NotificationMailer.document_update_email(user, Document.find_by_title(@title)).deliver

            if user.digest_pref == "daily"
                NotificationMailer.new_document_email(user, file).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
            elsif user.digest_pref == "weekly"
                NotificationMailer.new_document_email(user, file).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
            else
                NotificationMailer.new_document_email(user, file).deliver
            end
        end
    end

    def send_doc_email_update(file)
        User.all.each do |user|
            if user.digest_pref == "daily"
                NotificationMailer.document_update_email(user, file).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
            elsif user.digest_pref == "weekly"
                NotificationMailer.document_update_email(user, file).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
            else
                NotificationMailer.document_update_email(user, file).deliver
            end
        end
    end 

    def send_announcement_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver
                end
            end
        end
    end

    def send_announcement_update_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver
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
    
    def generate_daily(records)
        @records = records
        @subject = "Daily Digest for " + Time.now.strftime("%m/%d")
        
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
                
                #NotificationMailer.daily_digest_email(user, @subject, @content)
            end
        end
    end
        
end
