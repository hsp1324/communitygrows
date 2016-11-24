require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
    end
    
    describe "index" do
        it 'renders index page' do
            get :index, params: {user_id: users(:tester).id}
            expect(response).to render_template(:index)
        end
    end
    
    describe "get to a specific User's page" do
        it 'Successfully directs to that inner page' do
           get :user_profile , params: {id: users(:tester).id}
           expect(response).to render_template(:user_profile)
        end
    end


end
