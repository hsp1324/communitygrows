class NotificationMailer < ApplicationMailer
  default from: "mail.community.grows@gmail.com"
  def announcement_email(user,announcement)
  	@user = user
  	@announcement = announcement
  	if hasNoTitle(@announcement)
  	   mail(to: @user.email, subject: 'A New announcment from CG')
  	else
  	   mail(to: @user.email, subject: 'A New announcment from CG: ' + @announcement.title)
  	end
  end
  
  def hasNoTitle(announcement)
      if announcement.title.nil?
        return true
      end
    return false
  end
  
  def announcement_update_email(user, announcement)
  	@user = user
  	@announcement = announcement
  	if hasNoTitle(@announcement)
  	   mail(to: @user.email, subject: 'A CG announcement has been updated')
  	else
  	  mail(to: @user.email, subject: 'A CG announcement has been updated: ' + @announcement.title)
  	end
  end

  def new_document_email(user,document)
  	@user = user
  	@document = document
    mail(to: @user.email, subject: 'A new CG document has been added: ' + @document.title)
  end

  def document_update_email(user,document)
  	@user = user
  	@document = document
    mail(to: @user.email, subject: 'A CG document has been edited: ' + @document.title)
  end
  
  def new_event_email(user, event)
  	@user = user
  	@event = event
    mail(to: @user.email, subject: 'A new CG event has been created')
  end
  
  def event_update_email(user, event)
  	@user = user
  	@event = event
    mail(to: @user.email, subject: 'A CG event has been updated')
  end
  
  def daily_digest_email(user, subject, content)
    @content = content
    mail(to: user.email, subject: subject)
        
end
