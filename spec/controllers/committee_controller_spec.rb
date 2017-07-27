# require 'spec_helper'
# require 'rails_helper'

# describe CommitteeController do 
# 	fixtures :users
#     before(:each) do
#         sign_in users(:tester)
#         @committee = Committee.create!({name: "Nice", hidden: true, inactive: true})
#     end
# 	describe 'new committee' do
# 		it 'renders the new committee template' do
# 			get :new_committee
# 			expect(response).to render_template("new_committee")
# 		end
# # 		it 'redirects non-admin users' do
# #             sign_in users(:user)
# #             get :new_committee
# #             expect(response).to redirect_to root_path
# #             sign_out users(:user)
# #         end
# 	end

# 	describe 'create committee' do
# 		it 'redirects to the committee index page' do
# 			post :create_committee, params: {committee: {name: "Good Committee"}}
# 			expect(response).to redirect_to(committee_index_path)
# 		end
# 		it 'should not allow a blank name field' do
# 			post :create_committee, params: {committee: {name: ""}}
# 			expect(flash[:notice]).to eq("Committee name field cannot be blank.")
# 			expect(response).to redirect_to(new_committee_path)
# 		end
# 		it 'should not allow an already used committee name field' do
# 			expect(Committee).to receive(:has_name?).with("Good Committee").and_return(true)
# 			post :create_committee, params: {committee: {name: "Good Committee"}}
# 			expect(flash[:notice]).to eq("Committee name provided already exists. Please enter a different name.")
# 			expect(response).to redirect_to(new_committee_path)
# 		end

# 		it 'creates a committee' do
# 			expect(Committee).to receive(:create!).with(name: "Good Committee", hidden: true, inactive: true)
#             post :create_committee, params: {committee: {name: "Good Committee"}}
#             expect(flash[:notice]).to eq("Committee Good Committee was successfully created!")
#         end

#         it 'redirects non-admin users' do
#             sign_in users(:user)
#             post :create_committee, params: {committee: {name: "Good Committee"}}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end

# 	describe 'edit committee' do
# 		it 'renders the edit committee template' do
# 			get :edit_committee, params: {id: 1}
# 			expect(response).to render_template("edit_committee")
# 		end
# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :edit_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end

# 	describe 'update committee' do
# 		it 'redirects to the committee index page' do
# 			put :update_committee, params: {id: 1, committee: {name: "Good Committee"}}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it 'should not allow a blank name field' do
# 			put :update_committee, params: {id: 1, committee: {name: ""}}
# 			expect(flash[:notice]).to eq("Please fill in the committee name field.")
# 			expect(response).to redirect_to(edit_committee_path)
# 		end
# 		it 'should not allow an already used committee name field' do
# 			expect(Committee).to receive(:has_name?).with("Nice").and_return true
# 			put :update_committee, params: {id: 1, committee: {name: "Nice"}}
# 			expect(flash[:notice]).to eq("Committee name provided already exists. Please enter a different name.")
# 			expect(response).to redirect_to(edit_committee_path)
# 		end

# 		it 'updates the committee' do
#             put :update_committee, params: {id: 1, committee: {name: "Good Committee"}}
#             expect(response).to redirect_to(committee_index_path)
#         end

#         it 'redirects non-admin users' do
#             sign_in users(:user)
#             put :update_committee, params: {id: 1, committee: {name: "Good Committee"}}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end

# 	describe 'delete committee' do
# 		it 'redirects to the committee index page' do
# 			delete :delete_committee, params: {id: 1}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it "shows a flash delete message when committee successfully deleted" do
#             delete :delete_committee, params: {id: 1}
#             expect(flash[:notice]).to eq("Committee with name Nice deleted successfully.")
#         end

#         it 'redirects non-admin users' do
#             sign_in users(:user)
#             delete :delete_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end

# 	describe 'hide committee' do
# 		it 'redirects to the committee index page' do
# 			get :hide_committee, params: {id: 1}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it 'shows a flash message when committee successfully hidden' do
# 			get :hide_committee, params: {id: 1}
# 			expect(flash[:notice]).to eq("Nice successfully hidden.")
# 		end

# 		it 'sets the committee\'s hidden attribute to true' do
# 			expect_any_instance_of(Committee).to receive(:hide)
# 			get :hide_committee, params: {id: 1}
# 		end

# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :hide_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end

# 	describe 'show committee' do
# 		it 'redirects to the committee index page' do
# 			get :show_committee, params: {id: 1}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it 'shows a flash message when committee successfully shown' do
# 			get :show_committee, params: {id: 1}
# 			expect(flash[:notice]).to eq("Nice successfully shown.")
# 		end

# 		it 'sets the committee\'s hidden attribute to false' do
# 			expect_any_instance_of(Committee).to receive(:show)
# 			get :show_committee, params: {id: 1}
# 		end

# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :show_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end
	
	
# 	describe 'activate committee' do
# 		it 'redirects to the committee index page' do
# 			get :activate_committee, params: {id: 1}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it 'shows a flash message when committee successfully active' do
# 			get :activate_committee, params: {id: 1}
# 			expect(flash[:notice]).to eq("Nice successfully made active.")
# 		end

# 		it 'sets the committee\'s hidden attribute to true' do
# 			expect_any_instance_of(Committee).to receive(:activate)
# 			get :activate_committee, params: {id: 1}
# 		end

# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :activate_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end



# 	describe 'Inactivate committee' do
# 		it 'redirects to the committee index page' do
# 			get :inactivate_committee, params: {id: 1}
# 			expect(response).to redirect_to(committee_index_path)
# 		end

# 		it 'shows a flash message when committee successfully inactive' do
# 			get :inactivate_committee, params: {id: 1}
# 			expect(flash[:notice]).to eq("Nice successfully made inactive.")
# 		end

# 		it 'sets the committee\'s hidden attribute to false' do
# 			expect_any_instance_of(Committee).to receive(:inactivate)
# 			get :inactivate_committee, params: {id: 1}
# 		end

# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :inactivate_committee, params: {id: 1}
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
# 	end
	
# end

