require 'rails_helper'
RSpec.describe Category, type: :model do
    before(:each) do 
      @category = Category.new({:name => "jjjnet"})
    end

    describe "new category" do
	    it "creates new category" do
	    	expect(@category.name).to eq("jjjnet")
	    end
	    it "has documents" do
	    	expect(@category).to respond_to(:documents)
	    end
    end

    describe "has_name" do
      it "returns false if no record with given name exists" do
        expect(Category).to receive(:where).with(name: "tenjjj").and_return([])
        expect(Category.has_name?("tenjjj")).to be(false)
      end
      it "returns true if a record with given name exists" do
        expect(Category).to receive(:where).with(name: "jjjnet").and_return([double("Matching Record")])
        expect(Category.has_name?("jjjnet")).to be(true)
      end
    end

    describe "hide" do
      it "sets hidden attribute to true" do
        @category.hidden = false
        @category.hide
        expect(@category.hidden?).to be(true)
      end
    end

    describe 'show' do
      it 'sets hidden attribute to false' do
        @category.hidden = true
        @category.show
        expect(@category.hidden?).to be(false)
      end
    end
end