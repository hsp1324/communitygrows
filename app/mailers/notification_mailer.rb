class NotificationMailer < ApplicationMailer
  default from: "communitygrows2@gmail.com"
  def announcement_email(user,announcement)
  	@user = user
  	@announcement = announcement
    mail(to: @user.email, subject: 'New Announcement Created: ' + @announcement.title)
  end

  def announcement_update_email(user, announcement)
  	@user = user
  	@announcement = announcement
    mail(to: @user.email, subject: 'Announcement Updated: ' + @announcement.title)
  end

  def new_document_email(user,document)
  	@user = user
  	@document = document
    mail(to: @user.email, subject: 'New Document Created')
  end

  def document_update_email(user,document)
  	@user = user
  	@document = document
    mail(to: @user.email, subject: 'Document Edited')
  end
  
  def new_event_email(user, event)
  	@user = user
  	@event = event
    mail(to: @user.email, subject: 'New Event Created')
  end
  
  def event_update_email(user, event)
  	@user = user
  	@event = event
    mail(to: @user.email, subject: 'Event Edited')
  end
end
