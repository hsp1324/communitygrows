require 'rails_helper'
require 'spec_helper'

RSpec.describe SubcommitteeController, type: :controller do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
    end
    describe 'index' do
       it 'renders index page' do
           get :index, params: {committee_type: "executive"}
           expect(response).to render_template(:index)
       end
    end
end