require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    fixtures :users

    before(:each) do
        sign_in users(:tester)
        post :create, params: {:event=>{:title=>"Soccer", location: "My House", description: "It is going up!", :date=> Time.now, :url=>"www.google.com"}}
    end
    
    describe "create event" do
        it 'creates a events' do
            post :create, params: {:event=>{title: "Boxing", location: "Manhattan", description: "It is going down!", :date=> Time.now,:url=>"www.google.com"}}
            expect(flash[:notice]).to eq("Event titled Boxing created successfully and email was successfully sent.")
        end
        it 'requires a title' do
            post :create, params: {:event=>{title: "", location: "Manhattan", description: "It is going down!", :date=> Time.now, :url=>"www.google.com"}}
            expect(flash[:notice]).to eq("Title field cannot be left blank.")
        end
        it 'requires a date' do
            post :create, params: {:event=>{title: "Boxing", location: "Manhattan", description: "It is going down!", date: "", :url=>"www.google.com"}}
            expect(flash[:notice]).to eq("Date field cannot be left blank.")
        end
        it 'requires a valid date' do
            post :create, params: {:event=>{title: "Boxing", location: "Manhattan", description: "It is going down!", date: "2018-13-05  04:33AM", :url=>"www.google.com"}}
            expect(flash[:notice]).to eq("Date must be formated as YYYY-MM-DD  HH:mm(AM/PM) no parentheses")
        end
        it 'requires a correctly formatted date' do
            post :create, params: {:event=>{title: "Boxing", location: "Manhattan", description: "It is going down!", date: "A-B_C-D-E-F-G-H_J-I-e_W-h-S-h_e-I", :url=>"www.google.com"}}
            expect(flash[:notice]).to eq("Date was not correctly formatted, please follow provided format.")
        end
    end

    describe 'edit event' do
        it 'edits the event' do
            get :edit, params: {id: Event.find_by_title("Soccer").id}
            expect(response).to render_template(:edit)
        end 
    end

    describe 'update event' do
    	it 'updates the event' do
    		post :update, params: {id: Event.find_by_title("Soccer").id, event: {title: "Basketball", location: "My House", description: "It is going up!", date: Time.now, url: "www.google.com"}}
            expect(flash[:notice]).to eq("Event was updated and email was successfully sent.")
        end
        it 'requires a title' do
            post :update, params: {id: Event.find_by_title("Soccer").id, event: {title: "", location: "Manhattan", description: "It is going down!", date: Time.now, url: "www.google.com"}}
            expect(flash[:notice]).to eq("Title field cannot be left blank.")
        end
        it 'requires a date' do
            post :update, params: {id: Event.find_by_title("Soccer").id, event: {title: "Boxing", location: "Manhattan", description: "It is going down!", date: "", url: "www.google.com"}}
            expect(flash[:notice]).to eq("Date field cannot be left blank.")
        end
        it 'requires a valid date' do
            post :update, params: {id: Event.find_by_title("Soccer").id, event: {title: "Boxing", location: "Manhattan", description: "It is going down!", date: "2018-13-05  04:33AM", url: "www.google.com"}}
            expect(flash[:notice]).to eq("Date must be formated as YYYY-MM-DD  HH:mm(AM/PM) no parentheses")
        end
        it 'requires a correctly formatted date' do
            post :update, params: {id: Event.find_by_title("Soccer").id, event: {title: "Boxing", location: "Manhattan", description: "It is going down!", date: "A-B_C-D-E-F-G-H_J-I-e_W-h-S-h_e-I", url: "www.google.com"}}
            expect(flash[:notice]).to eq("Date was inproperly formatted, please follow provided format.")
        end
    end


    describe 'delete event' do
    	it 'deletes the event' do
    		temp_id = Event.find_by_title("Soccer").id
    		post :delete, params: {id: Event.find_by_title("Soccer").id}
    		expect(Event.find_by_id(temp_id)).to be(nil)
    	end
    end
end

