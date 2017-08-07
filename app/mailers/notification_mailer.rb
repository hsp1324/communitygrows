class NotificationMailer < ApplicationMailer
  default from: "mail.community.grows@gmail.com"
  
  def helper(user, type, update)
    @user = user
    if update
      text = 'has been updated'
    else
      text = 'has been created'
    end
    if type == "announcement"
      text = "An Announcement " + text + " at CG"
    elsif type == "document"
      text = "A Document " + text + " at CG"
    elsif type == "emergency"
      text = "An Emergency Announcement " + text + " at CG"
    elsif type == "meeting"
      text = "A Meeting " + text + " at CG"
    end
    return text
  end
  
  def committee_helper(user, name, old_name, description)
    @user = user
    @name = name
    @old_name = old_name
    @description = description
  end
  
  def member_email(committee, user, new_users)
    @user = user
    @new_users = new_users
    @committee = committee
    mail(to: @user.email, subject: "New members have been added to your committee")
  end
  
  def announcement_email(user, announcement)
  	@announcement = announcement
  	subject = helper(user, "announcement", false)
    mail(to: @user.email, subject: subject)
  end
  
  def emergency_email(user, announcement)
    @announcement = announcement
    subject = helper(user, "emergency", false)
  	mail(to: @user.email, subject: subject)
  end
  
  def announcement_update_email(user, announcement)
  	@announcement = announcement
    subject = helper(user, "announcement", true)
  	mail(to: @user.email, subject: subject)
  end

  def document_email(user,document)
  	@document = document
    subject = helper(user, "document", false)
  	mail(to: @user.email, subject: subject)
  end

  def document_update_email(user,document)
  	@document = document
    subject = helper(user, "document", true)
  	mail(to: @user.email, subject: subject)
  end
  
  def document_transfer_email(user, document)
    @user = user
  	@document = document
  	mail(to: @user.email, subject: 'A CG document has been transferred')
  end
  
  def meeting_email(user, meeting)
    @meetingt = meeting
    subject = helper(user, "meeting", false)
  	mail(to: @user.email, subject: subject)
  end
  
  def meeting_update_email(user, meeting)
    @meetingt = meeting
    subject = helper(user, "meeting", true)
  	mail(to: @user.email, subject: subject)
  end
  
  def committee_update_email(user, old_name, name, description)
    committee_helper(user, old_name, name, description)
    subject = old_name + " Committee Has Been Updated"
    mail(to: @user.email, subject: subject)
  end
  
  def committee_name_update_email(user, old_name, name)
    committee_helper(user, old_name, name, "")
    subject = old_name + " Committee's Name Has Changed"
    mail(to: @user.email, subject: subject)
  end
  
  def committee_description_update_email(user, name, description)
    committee_helper(user, "", name, description)
    subject = name + " Committee's Description Has Changed"
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
