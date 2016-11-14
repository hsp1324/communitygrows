require 'spec_helper'
require 'rails_helper'

describe DocumentsController do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
        Category.create!({id: 1, name: 'Good Category'})
        post :create_file, params: {file: {title: 'RepoTest', url: 'https://www.google.com/', committee_type: 'boardoverview', category_id: 1}}
        @doc = Document.find_by_title('RepoTest')
    end
    
    describe 'create new document (file)' do
        it 'renders the new document view' do
            get :new_file
            expect(response).to render_template(:new_file)
        end
        
        it 'can create a new document' do
            post :create_file, params: {file: {title: 'something', url: 'something.com', committee_type: 'boardoverview', category_id: 1}}
            expect(Document.find_by_title('RepoTest').title).to eql('RepoTest')
        end
        
        it 'checks for valid doc inputs' do
            post :create_file, params: {file: {title: 'something', committee_type: :internal}}
            expect(flash[:notice]).to eq('Populate all fields before submission.')
        
            post :create_file, params: {file: {title: 'something', url: 'something', committee_type: 'boardoverview', category_id: 1}}
            expect(flash[:notice]).to eq('Please enter a valid URL.')
        end
        
        it 'production env sends email' do
            allow(Rails.env).to receive(:production?).and_return true
            post :create_file, params: {file: {title: 'something', url: 'something.com', committee_type: 'boardoverview', category_id: 1}}
        end
    end
    
    describe 'accessing document page (index)' do
        it 'accesses the index page successfully' do
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe 'edit/update document (file) in the doc info page' do
        before(:each) do
            get :info_file, params: {format: @doc.id}
        end
        
        it 'edits a document' do
            # put :info_file, params: {format: @doc.id}
            put :update_file, params: {format: @doc.id, file: {title: 'ccc', url: 'ddddd.com', committee_type: 'boardoverview', category_id: 1}}
            expect(page).to redirect_to(:documents)
            expect(Document.find(@doc.id).title).to eql('ccc')
        end
        
        it 'checks for populated fields' do
            put :update_file, params: {format: @doc.id, file: {title: 'ccc', committee_type: 'boardoverview', category_id: 1}}
            expect(flash[:notice]).to eq('Populate all fields before submission.') 
        end
        
        it 'checks validity of URL' do
            put :update_file, params: {format: @doc.id, file: {title: 'ccc', url: 'ddddd', committee_type: 'boardoverview', category_id: 1}}
            expect(flash[:notice]).to eq('Please enter a valid URL.') 
        end
        
        it 'production env sends email' do
            allow(Rails.env).to receive(:production?).and_return true
            put :update_file, params: {format: @doc.id, file: {title: 'ccc', url: 'ddddd.com', committee_type: 'boardoverview', category_id: 1}}
        end
    end
    
    describe 'delete document' do
        it 'shows a flash delete message when document successfully deleted' do
            get :delete_file, params: {format: @doc.id}
            expect(flash[:notice]).to eq("Document with title [#{@doc.title}] deleted successfully.")
        end
        
        it 'should redirect to the documents repo page after deletion' do
            get :delete_file, params: {format: @doc.id}
            expect(response).to redirect_to(:documents)
        end
    end
    
    
    describe 'Document info page' do
        before(:each) do
            get :info_file, params: {format: @doc.id}
        end
        
        it 'should render the doc info page' do
            expect(response).to render_template(:info_file)
        end
    end
    
    describe 'Mark as Read' do
        before(:each) do
            get :info_file, params: {format: @doc.id}
        end

        # No longer redirects, as it is now a pure Ajax request. -Nathan       
        # it 'redirect to the info_file page after marked as read changed' do
        #     @request.env['HTTP_REFERER'] = info_file_path
        #     post :mark_as_read, params: {id: @doc.id}
        #     expect(response).to redirect_to(info_file_path)
        # end
        
        it 'returns json for marked as read if previously not read' do
            @request.env['HTTP_REFERER'] = info_file_path
            post :mark_as_read, params: {id: @doc.id}
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['result']).to eq('Read')
        end
        
        it 'returns json for marked as not read if previously read' do
            @request.env['HTTP_REFERER'] = info_file_path
            post :mark_as_read, params: {id: @doc.id}
            # Same controller method twice to mark as not read.
            post :mark_as_read, params: {id: @doc.id}
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['result']).to eq('Not Read')
        end
    end
end   

