class NotificationMailer < ApplicationMailer
  default from: "communitygrows2@gmail.com"
  def announcement_email(user,announcement)
  	@user = user
  	@announcement = announcement
  	if @announcement.title.nil?
  	   mail(to: @user.email, subject: 'A New announcment from CG')
  	else
  	   mail(to: @user.email, subject: 'A New announcment from CG: ' + @announcement.title)
  	end
  end

  def announcement_update_email(user, announcement)
  	@user = user
  	@announcement = announcement
  	if @announcement.title.nil?
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
end
