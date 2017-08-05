require 'spec_helper'
require 'rails_helper'

describe MeetingController do 
	fixtures :users
	fixtures :meetings
    before(:each) do
        sign_in users(:tester)
        @meeting = Meeting.create!({name: "Nice"})
		@test_admin = User.find_by(name: "Rspec_admin")
		@test_meeting = Meeting.find_by(name: "Nice")
# 		@test_date = Meeting.find_by(name: )
    end
	describe 'new meeting' do
		it 'renders the new meeting template' do
			get :new_meeting
			expect(response).to render_template("new_meeting")
		end
# 		it 'redirects non-admin users' do
#             sign_in users(:user)
#             get :new_meeting
#             expect(response).to redirect_to root_path
#             sign_out users(:user)
#         end
	end

	describe 'create meeting' do
		it 'redirects to the meeting index page' do
			post :create_meeting, params: {meeting: {name: "Good Meeting"}}
			expect(response).to redirect_to(new_meeting_path)
		end
		it 'should not allow a blank name field' do
			post :create_meeting, params: {meeting: {name: ""}}
			expect(flash[:notice]).to eq("Meeting name field cannot be blank.")
			expect(response).to redirect_to(new_meeting_path)
		end
		it 'should not allow an already used meeting name field' do
			expect(Meeting).to receive(:has_name?).with("Good Meeting").and_return(true)
			post :create_meeting, params: {meeting: {name: "Good Meeting"}}
			expect(flash[:notice]).to eq("Meeting name provided already exists. Please enter a different name.")
			expect(response).to redirect_to(new_meeting_path)
		end
		
		# it 'creates a meeting' do
		# 	expect(Meeting).to receive(:create!).with(name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website")
  #          post :create_meeting, params: {meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
  #          expect(flash[:notice]).to eq("Meeting Good Meeting was successfully created!")
  #      end
   
		# it 'creates a meeting without fill in everything' do
		# 	expect(Meeting).to receive(:create!).with(name: "Good Meeting")
  #          post :create_meeting, params: {meeting: {name: "Good Meeting"}}
  #          expect(flash[:notice]).to eq("Please fill in the description field.")
  #      end

        it 'redirects non-admin users' do
            sign_in users(:user)
            post :create_meeting, params: {meeting: {name: "Good Meeting"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'edit meeting' do
		it 'renders the edit meeting template' do
			get :edit_meeting, params: {id: @test_meeting.id}
			expect(response).to render_template("edit_meeting")
		end
		it 'redirects non-admin users' do
            sign_in users(:user)
            get :edit_meeting, params: {id: @test_meeting.id}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'update meeting' do
		it 'redirects to the meeting index page' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting"}}
			expect(response).to redirect_to(edit_meeting_path)
		end

		it 'should not allow a blank name field' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: name [Please Fill in name], ")
			expect(response).to redirect_to(edit_meeting_path)
		end
		# it 'should not allow an already used meeting name field' do
		# 	expect(Meeting).to receive(:has_name?).with("Nice").and_return true
		# 	put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Nice", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
		# 	expect(flash[:errors]).to eq("Meeting name provided already exists. Please enter a different name.")
		# 	expect(response).to redirect_to(edit_meeting_path)
		# end

		it 'updates the meeting' do
            put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting"}}
            expect(response).to redirect_to(edit_meeting_path)
        end
        
        
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end
	
	describe 'update_meeting_date' do 
		it 'should not allow a blank date field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Nice", date: "", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: date [Please fill in the date field.], ")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct meeting_date' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {date: "11/22/1994"}}
			expect(flash[:notice]).to eq("Successfully Updated: date, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
		it 'meeting date should be in MM/DD/YYYY format' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "hungry", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: date [New date must be in MM/DD/YYYY format], ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end		
		
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {date: "11/22/1994"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end		
		
end

	describe 'update_meeting_time' do 
	    
		it 'should not allow a blank meeting field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: time [Please fill in the time field.], ")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct meeting_time' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {time: "11:22 PM"}}
			expect(flash[:notice]).to eq("Successfully Updated: time, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
		it 'meeting time should be in HH:MM AM/PM format' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "hungry", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: time [New time must be in HH:MM AM/PM format], ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end		
		
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {time: "11:22 PM"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end				
end

	describe 'update_meeting_location' do 
	    
		it 'should not allow a blank location field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: location [Please fill in the location field.], ")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct meeting_location' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {location: "California"}}
			expect(flash[:notice]).to eq("Successfully Updated: location, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {location: "California"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end		
end

	describe 'update_meeting_description' do 
	    
		it 'should not allow a blank description field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: ""}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: description [Please fill in the description field.], ")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct description' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {description: "fiveguys vs bongo burger"}}
			expect(flash[:notice]).to eq("Successfully Updated: description, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {description: "fiveguys vs bongo burger"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end		
end

	describe 'update_meeting_agenda' do 
	    
		it 'should not allow a blank agenda field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates:")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct agenda' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {agenda: "https://www.google.com/"}}
			expect(flash[:notice]).to eq("Successfully Updated: agenda, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
		it 'without https agenda' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {agenda: "google.com"}}			
			expect(flash[:notice]).to eq("Successfully Updated: agenda, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end		
		it 'agenda should be in URL format' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website", agenda: "hungry"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: agenda [Please enter a valid URL for agenda.], ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end	
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {agenda: "https//google.com"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end		
end


	describe 'update_meeting_hangout' do 
	    
		it 'should not allow a blank hangout field' do
			get :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website", hangout: ""}}
			expect(flash[:errors]).to eq("Unsucessfull Updates:")
			expect(response).to redirect_to(edit_meeting_path)
		end
		
		it 'correct hangout' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {hangout: "https://www.google.com/"}}
			expect(flash[:notice]).to eq("Successfully Updated: hangout, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
		
		it 'without https hangout' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {hangout: "google.com"}}			
			expect(flash[:notice]).to eq("Successfully Updated: hangout, ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end
		it 'hangout should be in URL format' do
			put :update_meeting, params: {id: @test_meeting.id, meeting: {name: "Good Meeting", date: "06/12/1991", time: "04:04 AM", location: "Campbell", description: "Work on the website", hangout: "hungry"}}
			expect(flash[:errors]).to eq("Unsucessfull Updates: hangout [Please enter a valid URL for hangout.], ")
			expect(response).to redirect_to(edit_meeting_path)
			
		end	
		
        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_meeting, params: {id: @test_meeting.id, meeting: {hangout: "https://www.google.com/"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end	

	describe 'delete meeting' do
		it 'redirects to the meeting index page' do
			delete :delete_meeting, params: {id: @test_meeting.id}
			expect(response).to redirect_to(meeting_index_path)
		end

		it "shows a flash delete message when meeting successfully deleted" do
            delete :delete_meeting, params: {id: @test_meeting.id}
            expect(flash[:notice]).to eq("Meeting with name Nice deleted successfully.")
        end

        it 'redirects non-admin users' do
            sign_in users(:user)
            delete :delete_meeting, params: {id: @test_meeting.id}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

end

end 