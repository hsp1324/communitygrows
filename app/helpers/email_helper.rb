module EmailHelper
	def send_doccom_email(committee, title)
		User.all.each do |user|
			if current_user.admin?
    			NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
    		elsif (committee == user.internal?) or (committee == user.external?) or (committee == user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: Time.now.tomorrow.noon())
                elsif user.digest_pref == "weekly"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: Time.now.next_week.noon())
                else
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
                end
            end
		end
	end
	def send_doccom_update_email(committee, title)
		User.all.each do |user|
			if current_user.admin?
    			NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
    		elsif (committee == user.internal?) or (committee == user.external?) or (committee == user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: Time.now.tomorrow.noon())
                elsif user.digest_pref == "weekly"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: Time.now.next_week.noon())
                else
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
                end
            end
		end
	end
end
