require 'spec_helper'
require 'rails_helper'

describe CategoryController do 
	fixtures :users
    before(:each) do
        sign_in users(:tester)
        @category = Category.create!({id: 25, name: "Crazy Category", hidden: false})
    end
	describe 'new category' do
		it 'renders the new category template' do
			get :new_category
			expect(response).to render_template("new_category")
		end
		it 'redirects non-admin users' do
            sign_in users(:user)
            get :new_category
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'create category' do
		it 'redirects to the category index page' do
			post :create_category, params: {category: {name: "Good Category"}}
			expect(response).to redirect_to(category_index_path)
		end
		it 'should not allow a blank name field' do
			post :create_category, params: {category: {name: ""}}
			expect(flash[:notice]).to eq("Category name field cannot be blank.")
			expect(response).to redirect_to(new_category_path)
		end
		it 'should not allow an already used category name field' do
			expect(Category).to receive(:has_name?).with("Good Category").and_return(true)
			post :create_category, params: {category: {name: "Good Category"}}
			expect(flash[:notice]).to eq("Category name provided already exists. Please enter a different name.")
			expect(response).to redirect_to(new_category_path)
		end

		it 'creates a category' do
			expect(Category).to receive(:create!).with(name: "Good Category")
            post :create_category, params: {category: {name: "Good Category"}}
            expect(flash[:notice]).to eq("Category Good Category was successfully created!")
        end

        it 'redirects non-admin users' do
            sign_in users(:user)
            post :create_category, params: {category: {name: "Good Category"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'edit category' do
		it 'renders the edit category template' do
			get :edit_category, params: {id: 25}
			expect(response).to render_template("edit_category")
		end
		it 'redirects non-admin users' do
            sign_in users(:user)
            get :edit_category, params: {id: 25}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'update category' do
		it 'redirects to the category index page' do
			put :update_category, params: {id: 25, category: {name: "Good Category"}}
			expect(response).to redirect_to(category_index_path)
		end

		it 'should not allow a blank name field' do
			put :update_category, params: {id: 25, category: {name: ""}}
			expect(flash[:notice]).to eq("Please fill in the category name field.")#"The category name provided already exists. Please enter a different name.")
			expect(response).to redirect_to(edit_category_path)
		end
		it 'should not allow an already used category name field' do
			expect(Category).to receive(:has_name?).with("Crazy Category").and_return true
			put :update_category, params: {id: 25, category: {name: "Crazy Category"}}
			expect(flash[:notice]).to eq("Category name provided already exists. Please enter a different name.")
			expect(response).to redirect_to(edit_category_path)
		end

		it 'updates the category' do
            put :update_category, params: {id: 25, category: {name: "Good Category"}}
            expect(response).to redirect_to(category_index_path)
        end

        it 'redirects non-admin users' do
            sign_in users(:user)
            put :update_category, params: {id: 25, category: {name: "Good Category"}}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'delete category' do
		it 'redirects to the category index page' do
			delete :delete_category, params: {id: 25}
			expect(response).to redirect_to(category_index_path)
		end

		it "shows a flash delete message when category successfully deleted" do
            delete :delete_category, params: {id: 25}
            expect(flash[:notice]).to eq("Category with name Crazy Category deleted successfully.")
        end

        it 'redirects non-admin users' do
            sign_in users(:user)
            delete :delete_category, params: {id: 25}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'hide category' do
		it 'redirects to the category index page' do
			get :hide_category, params: {id: 25}
			expect(response).to redirect_to(category_index_path)
		end

		it 'shows a flash message when category successfully hidden' do
			get :hide_category, params: {id: 25}
			expect(flash[:notice]).to eq("Crazy Category successfully hidden.")
		end

		it 'sets the category\'s hidden attribute to true' do
			expect_any_instance_of(Category).to receive(:hide)
			get :hide_category, params: {id: 25}
		end

		it 'redirects non-admin users' do
            sign_in users(:user)
            get :hide_category, params: {id: 25}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end

	describe 'show category' do
		it 'redirects to the category index page' do
			get :show_category, params: {id: 25}
			expect(response).to redirect_to(category_index_path)
		end

		it 'shows a flash message when category successfully shown' do
			get :show_category, params: {id: 25}
			expect(flash[:notice]).to eq("Crazy Category successfully shown.")
		end

		it 'sets the category\'s hidden attribute to false' do
			expect_any_instance_of(Category).to receive(:show)
			get :show_category, params: {id: 25}
		end

		it 'redirects non-admin users' do
            sign_in users(:user)
            get :show_category, params: {id: 25}
            expect(response).to redirect_to root_path
            sign_out users(:user)
        end
	end
end

