require 'spec_helper'
require 'rails_helper'
require 'email_helper'

describe AnnouncementController do 
    fixtures :users
    fixtures :meetings
    fixtures :announcements
    fixtures :committees
    before(:each) do
        sign_in users(:tester)
        @sun_committee = Committee.find_by(name: "sun")
        # puts "*"*100
        # puts @sun_committee.id
        # puts "*"*100
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        post :create_announcement, params: {committee_id: @sun_committee.id, title: "Rspec", content: "Is for testing"}
        @a = Announcement.where(title: "Rspec").first
        
    end
    describe 'show the announcements' do
        it 'shows main announcements' do
            get :show_announcements, params: {categories: [:dashboard]}
            expect(response).to render_template(:show_announcements)
        end
        it 'shows subcommittee announcments' do
            get :show_announcements, params: {categories: [:external, :internal, :executive]}
            expect(response).to render_template(:show_announcements)
        end
    end
    describe 'new announcement' do
        it 'renders the new announcment template' do
            get :new_announcement, params: {committee_id: @a.committee_id}
            expect(response).to render_template(:new_announcement)
        end
        it 'creates a new announcement' do
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @a.committee_id))
        end
    end
    describe 'create announcement' do
        it 'doesn\'t accept an empty title' do
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
            # Rails.env.stub(:production? => true
            # ENV["RAILS_ENV"]  = production
            post :create_announcement, params: {committee_id: @a.committee_id, title: ''}
            expect(flash[:notice]).to eq("Title field cannot be left blank.")
            expect(response).to redirect_to(new_committee_announcement_path)
        end

        # describe 'emails' do
        #     # before(:each) do
        #     #     Rails.env.stub(:production? => true)
        #     # end
        #     it 'internal' do
        #         expect(Rails.env).to receive(:production?).and_return(true)
        #         allow(NotificationMailer).to receive_message_chain(:announcement_email, :deliver).and_return(true)
        #         post :create_announcement, params: {committee_id: @a.committee_id, title: "a"}
        #     end
        #     it 'external' do
        #         expect(Rails.env).to receive(:production?).and_return(true)
        #         allow(NotificationMailer).to receive_message_chain(:announcement_email, :deliver).and_return(true)
        #         post :create_announcement, params: {committee_id: @a.committee_id, title: "a"}
        #     end
        #     it 'executive' do
        #         expect(Rails.env).to receive(:production?).and_return(true)
        #         allow(NotificationMailer).to receive_message_chain(:announcement_email, :deliver).and_return(true)
        #         post :create_announcement, params: {committee_id: @a.committee_id, title: "a"}
        #     end
        # end
    end
    describe 'edit announcement' do
        it 'renders edit announcment page' do
            get :edit_announcement, params: {announcement_id: @a.id, committee_id: @a.committee_id}
            expect(response).to render_template(:edit_announcement)
        end
        it 'updates incorrectly' do 
            put :update_announcement, params: {title: nil, content: @a.content, announcement_id: @a.id, committee_id: @a.committee_id, announcement: {id: @a.id}}
            expect(response).to redirect_to(edit_committee_announcement_path(committee_id: @a.committee_id, announcement_id: @a.id))
        end
        it 'updates the announcement' do
            put :update_announcement, params: {title: @a.title, content: @a.content, announcement_id: @a.id, committee_id: @a.committee_id, announcement: {id: @a.id}}
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @a.committee_id))
        end
    end
    describe 'delete announcement' do   
        it 'deletes an announcement' do
            delete :delete_announcement, params: {announcement_id: @a.id, committee_id: @a.committee_id}
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @a.committee_id))
            
        end
    end
    describe 'update announcement' do
        describe 'emails' do
            before(:each) do
                allow(Rails.env).to receive(:production?).and_return(true)
            end
            it 'subcommittee' do
                expect(Rails.env).to receive(:production?).and_return(true)
                allow(NotificationMailer).to receive_message_chain(:announcement_update_email, :deliver).and_return(true)
                put :update_announcement, params: {title: "a", content: @a.content, announcement_id: @a.id, committee_id: @a.committee_id, announcement: { id: @a.id }}
            end
        end
    end

    describe 'search' do
        it 'searches right' do 
            post :search_announcements, params: {search: @a.title}
            expect(response).to render_template(:show_announcements)
        end
    end
end