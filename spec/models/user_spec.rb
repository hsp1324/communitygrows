require 'rails_helper'

RSpec.describe User, type: :model do
    describe "new user" do
  	    it "create new user" do
  	    	u = User.new
  	    	u.email = "jack@gmail.com"
  	    	u.delete
  	    end
    end
    
    describe "user functionalities" do
      before(:each) do
        @u = User.new
  	    @u.email = "jack@gmail.com"
  	  end
  	  
      it "hasn't read any documents when initialized" do
        doc = Document.new
        expect(@u.has_read?(doc)).to be(false)
      end
      
      it "has read a document when doc is in user's doc list" do
        doc = Document.new
        @u.documents << doc
        expect(@u.has_read?(doc)).to be(true)
      end
    end

end
