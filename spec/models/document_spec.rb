require 'rails_helper'
RSpec.describe Document, type: :model do
    describe "new document" do
    	it "should belong to a category" do
    		document = Document.new
    		expect(document).to respond_to(:category)
    	end
    end
end