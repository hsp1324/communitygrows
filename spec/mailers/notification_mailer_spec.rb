require "rails_helper"
require "spec_helper"
require 'rspec/active_model/mocks'

RSpec.describe NotificationMailer, type: :mailer do
  fixtures :users
  fixtures :meetings
  fixtures :committees
  fixtures :announcements
  before(:each) do
    # sign_in users(:tester)
    @test_admin = User.find_by(name: "Rspec_admin")
    @test_user = User.find_by(name: "Rspec_user")
    @test_committee = Committee.find_by(name: "sun")
    @test_meeting = Meeting.find_by(name: "Big Boy Meeting")
    @test_announcement_title = Announcement.find_by(title: "test")
    @test_announcement_notitle = Announcement.find_by(content: "no_title announcement")
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

  describe 'create document' do
    let(:user) { mock_model User, name: 'James', email: 'james@email.com' }
    let(:document) { mock_model Document, document: 'Important Read', title: 'Cool', content: 'www.communitygrows.com/document/example.pdf' }

    # let(:mail) { NotificationMailer.new_document_email(user,document)}

    # it 'renders the subject' do
    #   expect(mail.subject).to eql('A new CG document has been added: Cool')
    # end

    # it 'renders the receiver email' do
    #   expect(mail.to).to eql([user.email])
    # end

    # it 'renders the sender email' do
    #   expect(mail.from).to eql(['communitygrows2@gmail.com'])
    # end


    # it 'contains content' do
    #   expect(mail.body.encoded).to include("document")
    # end
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


end
