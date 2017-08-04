class NotificationMailer < ApplicationMailer
  default from: "mail.community.grows@gmail.com"
  
  def hasNoTitle(object)
    if object.title.nil?
      return true
    end
    return false
  end
  
  def announcement_email(user, announcement)
  	@user = user
  	@announcement = announcement
  	if hasNoTitle(@announcement)
  	  mail(to: @user.email, subject: 'A New announcment from CG')
  	else
  	  mail(to: @user.email, subject: 'A New announcment from CG: ' + @announcement.title)
  	end
  end
  
  def emergency_email(user, announcement)
    @user = user
    @announcement = announcement
    if hasNoTitle(@announcement)
  	  mail(to: @user.email, subject: 'An Emergency announcment from CG')
  	else
  	  mail(to: @user.email, subject: 'An Emergency announcment from CG: ' + @announcement.title)
    end
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

  def document_email(user,document)
  	@user = user
  	@document = document
  	if hasNoTitle(@document)
      mail(to: @user.email, subject: 'A new CG document has been added')
  	else
      mail(to: @user.email, subject: 'A new CG document has been added: ' + @document.title)
  	end
  end

  def document_update_email(user,document)
  	@user = user
  	@document = document
  	if hasNoTitle(@announcement)
  	  mail(to: @user.email, subject: 'A CG document has been updated')
  	else
  	  mail(to: @user.email, subject: 'A CG document has been updated: ' + @document.title)
  	end
  end

  def daily_digest_email(user, subject, content)
    @content = content
    puts user.email
    mail(to: user.email, subject: subject)
  end
end
