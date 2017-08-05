require 'spec_helper'
require 'rails_helper'

describe DocumentCommitteeController do 
    fixtures :users
    fixtures :committees
    before(:each) do
        @sun_committee = Committee.find_by(name: "sun")
        sign_in users(:tester)
        post :create_document, params: {title: "before hook", url: "rspec.com", committee_id: 297062136}
        @doc = Document.where(title: "before hook").take
    end
    
    describe "create document" do
        it "has a flash method for unpopulated fields" do
            post :create_document, params: {title: "Rspec", committee_id: 297062136}
            expect(flash[:notice]).to eq("Populate all fields before submission.") 
        end
        
        
        it "checks validity of URL" do
            post :create_document, params: {title: "Rspec", url: "rspec", committee_id: 297062136}
            expect(flash[:notice]).to eq("Please enter a valid URL.") 
        end
        
        it 'creates a document' do
            post :create_document, params: {title: "Rspec", url: "rspec.com", committee_id: 297062136}
            expect(flash[:notice]).to eq("Document List creation successful and email was successfully sent.")
        end
        
        it "development env sends email" do
            allow(Rails.env).to receive(:development?).and_return(true)
            post :create_document, params: {title: "Rspec", url: "rspec.com", committee_id: 297062136}
        end
    end
    
    describe "edit document" do
        it 'renders edit page' do
            get :edit_document, params: {committee_id: @doc.committee_id, id: @doc.id}
            expect(response).to render_template(:edit_document)
        end
    end
    
    describe "update document" do
        it "checks for populated fields" do
            put :update_document, params: {document: {id: @doc.id}, url: "new_url.com", committee_id: @doc.committee_id}
            expect(flash[:notice]).to eq("Populate all fields before submission.") 
        end
        
        it "checks validity of URL" do
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url", committee_id: @doc.committee_id}
            expect(flash[:notice]).to eq("Please enter a valid URL.") 
        end
        
        it 'updates the document' do
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url.com", committee_id: @doc.committee_id}
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @doc.committee_id))
        end
        
        it "development env sends email" do
            allow(Rails.env).to receive(:development?).and_return(true)
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url.com", committee_id: @doc.committee_id}
        end
    end
    
    describe 'deleting document' do
        it 'deletes' do
            delete :delete_document, params: {committee_id: @doc.committee_id, document_id: @doc.id}
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @doc.committee_id))
        end
    end
    
    describe 'transfering document' do
        # please write test for transfering document ^_^
        # expect page to be redirected to a new page where user chooses which repository the document goes to
        # this test is currently incorrect and needs fixing!!
        
        it 'successfully shown in subcommittee_index_page' do
            get :transfer_document, params: {committee_id: @doc.committee_id, single_transfer: true, id: @doc.id}
        end 
        
        it 'successfully transferred' do
            @a = FactoryGirl.create(:category)
            doc_hash = {"#{@doc.title}": "Board Overview"}
            post :transfer_file_to_repository, params: {committee_id: @doc.committee_id, document_id: @doc.id, document: doc_hash}
            expect(response).to redirect_to(subcommittee_index_path(committee_id: @doc.committee_id))
            expect(flash[:notice]).to include("Documents were successfully transferred to Document Repository")
        end 
        
    end 
end