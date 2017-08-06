class NotificationMailer < ApplicationMailer
  default from: "mail.community.grows@gmail.com"
  
  def hasNoTitle(object)
    if object.title.nil?
      return true
    end
    return false
  end
  
  def member_email(committee, user, new_users)
    @user = user
    @new_users = new_users
    @committee = committee
    mail(to: @user.email, subject: "New members have been added to your committee")
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
  	if hasNoTitle(@document)
  	  mail(to: @user.email, subject: 'A CG document has been updated')
  	else
  	  mail(to: @user.email, subject: 'A CG document has been updated: ' + @document.title)
  	end
  end
  
  def document_transfer_email(user, document)
    @user = user
  	@document = document
  	if hasNoTitle(@document)
  	  mail(to: @user.email, subject: 'A CG document has been updated')
  	else
  	  mail(to: @user.email, subject: 'A CG document has been updated: ' + @document.title)
  	end
  end
  
  def meeting_email(user, meeting)
    @user = user
    @meeting = meeting
    mail(to: @user.email, subject: 'A new meeting has been planned!')
  end
  
  def meeting_update_email(user, meeting)
    @user = user
    @meeting = meeting
    mail(to: @user.email, subject: 'A meeting has been updated!')
  end
  
  def committee_update_email(user, old_name, name, description)
    @user = user
    @old_name = old_name
    @name = name
    @description = description
    subject = old_name + "Committee Has Been Updated"
    mail(to: @user.email, subject: subject)
  end
  
  def committee_name_update_email(user, old_name, name)
    @user = user
    @old_name = old_name
    @name = name
    subject = old_name + "Committee's Name Has Changed"
    mail(to: @user.email, subject: subject)
  end
  
  def committee_description_update_email(user, old_name, name, description)
    @user = user
    @name = name
    @description = description
    subject = name + "Committee's Description Has Changed"
    mail(to: @user.email, subject: subject)
  end
  
  def digest_email(user, subject, content)
    @user = user
    @subject = subject
    @content = content
    puts user.email
    mail(to: @user.email, subject: @subject)
  end
end
