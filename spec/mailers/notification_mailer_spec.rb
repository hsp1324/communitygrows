require "rails_helper"
require "spec_helper"
require 'rspec/active_model/mocks'

RSpec.describe NotificationMailer, type: :mailer do
  fixtures :users
  fixtures :meetings
  fixtures :committees
  fixtures :announcements
  fixtures :documents
  before(:each) do
    # sign_in users(:tester)
    @test_admin = User.find_by(name: "Rspec_admin")
    @test_user = User.find_by(name: "Rspec_user")
    @test_committee = Committee.find_by(name: "sun")
    @test_meeting = Meeting.find_by(name: "Big Boy Meeting")
    @test_announcement_title = Announcement.find_by(title: "test")
    @test_announcement_notitle = Announcement.find_by(content: "no_title announcement")
    @test_document = Document.find_by(title: "doc_goku")
  end
  
  describe 'send email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.member_email(@test_committee, @test_admin, @test_user)}

    it 'when new member added' do
      #   undefined method `html_safe' for #<User:0x00000006f47af8>
      #   Did you mean?  html_safe?
      #   ./app/views/notification_mailer/member_email.html.erb:10:in `_app_views_notification_mailer_member_email_html_erb___827385023122036191_42845320'
      expect(mail.subject).to eql('New members have been added to your committee')
    end
  end
  
  describe 'new announcement with title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.announcement_email(@test_admin, @test_announcement_title)}

    it 'send email' do
      expect(mail.subject).to eql('A New announcment from CG: test')
    end
  end
  
  
  describe 'new announcement without title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.announcement_email(@test_admin, @test_announcement_notitle)}

    it 'when new announcement without title added' do
      expect(mail.subject).to eql('A New announcment from CG')
    end
  end  
  
  
  describe 'new announcement with title and emergency_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.emergency_email(@test_admin, @test_announcement_title)}

    it 'send email' do
      expect(mail.subject).to eql('An Emergency announcment from CG: test')
    end
  end
  
  describe 'new announcement with notitle and emergency_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.emergency_email(@test_admin, @test_announcement_notitle)}

    it 'when new announcement without title added' do
      expect(mail.subject).to eql('An Emergency announcment from CG')
    end
  end 
  
  
  describe 'new announcement' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:announcement) { mock_model Announcement, title: 'Raining', content: 'It is raining' }

    let(:mail) { NotificationMailer.announcement_email(user,announcement)}

    it 'renders the subject' do
      expect(mail.subject).to include('A New announcment from CG:')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['mail.community.grows@gmail.com'])
    end

    it 'contains content' do
      expect(mail.body.encoded).to include(announcement.content)
    end
  end


  describe 'update announcement' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:announcement) { mock_model Announcement, title: 'Raining', content: 'It is raining' }

    let(:mail) { NotificationMailer.announcement_update_email(user,announcement)}

    it 'renders the subject' do
      expect(mail.subject).to include('A CG announcement has been updated:')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['mail.community.grows@gmail.com'])
    end


    it 'contains content' do
      expect(mail.body.encoded).to include(announcement.content)
    end
  end

  describe 'update announcement without title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.announcement_update_email(@test_admin, @test_announcement_notitle)}

    it 'send email without title' do
      expect(mail.subject).to include('A CG announcement has been updated')
    end
  end



  describe 'new document with title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, url: 'community.com', title: ""}
    let(:mail) { NotificationMailer.document_email(@test_admin, document)}

    it 'send email' do
      expect(mail.subject).to eql('A new CG document has been added: ')
    end
  end
  
  describe 'new document without title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, url: 'community.com', title: "Nice"}
    let(:mail) { NotificationMailer.document_email(@test_admin, document)}

    it 'when new announcement without title added' do
      expect(mail.subject).to eql('A new CG document has been added: Nice')
    end
  end 



  describe 'update document' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, document: 'Important Read', title: 'Cool', content: 'www.communitygrows.com/document/example.pdf' }

    let(:mail) { NotificationMailer.document_update_email(user,document)}

    it 'renders the subject' do
      expect(mail.subject).to eql('A CG document has been updated: Cool')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['mail.community.grows@gmail.com'])
    end

    it 'contains content' do
      expect(mail.body.encoded).to include("A change has been made to Cool.")
    end
  end


  describe 'update document without title' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, document: 'Important Read', title: '', content: 'www.communitygrows.com/document/example.pdf' }
    let(:mail) { NotificationMailer.document_update_email(user,document)}
    it 'send email' do
      expect(mail.subject).to eql('A CG document has been updated: ')
    end
  end


  # describe 'document_transfer_email with title' do
  #   let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
  #   let(:document) { mock_model Document, document: 'Important Read', title: 'test', content: 'www.communitygrows.com/document/example.pdf' , committee_id: @test_committee.id}
  #   let(:mail) { NotificationMailer.document_transfer_email(@test_admin, @test_document)}
  #   it 'send email' do
  #     expect(mail.subject).to eql('A CG document has been updated: test')
  #   end
  # end

  # describe 'document_transfer_email without title' do
  #   let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
  #   let(:document) { mock_model Document, document: 'Important Read', title: '', content: 'www.communitygrows.com/document/example.pdf', committee_id: @test_committee.id}
  #   let(:mail) { NotificationMailer.document_transfer_email(@test_admin, @test_document)}
  #   it 'when new announcement without title added' do
  #     puts "#"*100
  #     puts "@document.committee.name: #{@test_committee.id}"
  #     puts "#"*100
  #     expect(mail.subject).to eql('A CG document has been updated')
  #   end
  # end 


  describe 'meeting_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.meeting_email(@test_admin, @test_meeting)}

    it 'send email' do
      expect(mail.subject).to eql('A new meeting has been planned!')
    end
  end

  
  describe 'meeting_update_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.meeting_update_email(@test_admin, @test_meeting)}

    it 'send email' do
      expect(mail.subject).to eql('A meeting has been updated!')
    end
  end
  
  
  describe 'committee_update_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.committee_update_email(@test_admin, "old_goku", "new_goku", "new_goku is god")}

    it 'send email' do
      expect(mail.subject).to eql("old_goku Committee Has Been Updated")
    end
  end


  describe 'committee_name_update_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.committee_name_update_email(@test_admin, "old_goku", "new_goku")}

    it 'send email' do
      expect(mail.subject).to eql("old_goku Committee's Name Has Changed")
    end
  end
  
  
  describe 'committee_description_update_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.committee_description_update_email(@test_admin, "new_goku", "new_goku is god")}

    it 'send email' do
      expect(mail.subject).to eql("new_goku Committee's Description Has Changed")
    end
  end



  describe 'digest_email' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:mail) { NotificationMailer.digest_email(@test_admin, "subject_goku", "new_goku is god")}

    it 'send email' do
      expect(mail.subject).to eql("subject_goku")
    end
  end
end
