require 'spec_helper'
require 'rails_helper'

describe DocumentCommitteeController do 
    fixtures :users
    before(:each) do
        sign_in users(:tester)
        post :create_document, params: {title: "before hook", url: "rspec.com", committee_type: :internal}
        @doc = Document.where(title: "before hook").take
    end
    
    describe "create document" do
        it "has a flash method for unpopulated fields" do
            post :create_document, params: {title: "Rspec", committee_type: :internal}
            expect(flash[:notice]).to eq("Populate all fields before submission.") 
        end
        
        
        it "checks validity of URL" do
            post :create_document, params: {title: "Rspec", url: "rspec", committee_type: :internal}
            expect(flash[:notice]).to eq("Please enter a valid URL.") 
        end
        
        it 'creates a document' do
            post :create_document, params: {title: "Rspec", url: "rspec.com", committee_type: :internal}
            expect(flash[:notice]).to eq("Document List creation successful and email was successfully sent.")
        end
        
        it "development env sends email" do
            allow(Rails.env).to receive(:development?).and_return(true)
            post :create_document, params: {title: "Rspec", url: "rspec.com", committee_type: :internal}
        end
    end
    
    describe "edit document" do
        it 'renders edit page' do
            get :edit_document, params: {committee_type: @doc.committee_type, id: @doc.id}
            expect(response).to render_template(:edit_document)
        end
    end
    
    describe "update document" do
        it "checks for populated fields" do
            put :update_document, params: {document: {id: @doc.id}, url: "new_url.com", committee_type: @doc.committee_type}
            expect(flash[:notice]).to eq("Populate all fields before submission.") 
        end
        
        it "checks validity of URL" do
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url", committee_type: @doc.committee_type}
            expect(flash[:notice]).to eq("Please enter a valid URL.") 
        end
        
        it 'updates the document' do
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url.com", committee_type: @doc.committee_type}
            expect(response).to redirect_to(subcommittee_index_path(committee_type: @doc.committee_type))
        end
        
        it "development env sends email" do
            allow(Rails.env).to receive(:development?).and_return(true)
            put :update_document, params: {document: {id: @doc.id}, title: @doc.title, url: "new_url.com", committee_type: @doc.committee_type}
        end
    end
    
    describe 'deleting document' do
        it 'deletes' do
            delete :delete_document, params: {committee_type: @doc.committee_type, document_id: @doc.id}
            expect(response).to redirect_to(subcommittee_index_path(committee_type: @doc.committee_type))
        end
    end
    
    describe 'transfering document' do
        # please write test for transfering document ^_^
    end 
end