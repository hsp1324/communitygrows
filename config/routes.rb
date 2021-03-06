Rails.application.routes.draw do

  devise_for :users, path_names: {
    sign_up: ''
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#authenticate' #redirects to the login page
  resources :dashboard, :only => [:index]
  resources :admin, :only => [:index]
  resources :documents, :only => [:index]
  #resources :committee, :only => [:index]

  get 'admin/:id/edit_user' => 'admin#edit_user', as: :edit_user
  get 'admin/new_user' => 'admin#new_user', as: :new_user
  delete 'admin/:id' => 'admin#delete_user', as: :delete_user
  put 'admin/:id/update' => 'admin#update_user', as: :update_user
  post 'admin/create' => 'admin#create_user', as: :create_user


  get 'admin/new_announcement' => 'admin#new_announcement', as: :new_announcement
  put 'admin/create_announcement' => 'admin#create_announcement', as: :create_announcement
  get 'admin/:id/edit_announcement' => 'admin#edit_announcement', as: :edit_announcement
  put 'admin/:id/edit_announcement' => 'admin#update_announcement', as: :update_announcement
  get 'admin/:id/delete_announcement' => 'admin#delete_announcement', as: :delete_announcement
  
  
  get 'dashboard_announcements/:announcement_id/comments' => 'comment#index', as: :comment
  get 'dashboard_announcements/:announcement_id/comments/new_comment' => 'comment#new_comment', as: :new_comment
  post 'dashboard_announcements/:announcement_id/comments/create_comment' => 'comment#create_comment', as: :create_comment
  delete 'dashboard_announcements/:announcement_id/comments/delete_comment/:comment_id' => 'comment#delete_comment', as: :delete_comment

  # Account Info
  get 'account_details' => 'user#index', as: :user_credentials
  put 'account_details' => 'user#update_user_credentials', as: :update_user_credentials
  post 'account_details/emails/:user_id/' => 'user#updateEmailPreferences', as: :update_user_email_preference
  get 'new_user_main_announcement' => 'user#new_announcement', as: :new_user_announcement
  post 'user_committee_announcement' => 'user#create_announcement', as: :create_user_announcement
  # Subcommittee
  get 'subcommittee_index/:committee_id/' => 'subcommittee#index', as: :subcommittee_index
  
  # Subcommittee Announcement
  get 'subcommittee_index/:committee_id/new_announcement' => 'announcement#new_announcement', as: :new_committee_announcement
  post 'subcommittee_index/:committee_id/create_announcement' => 'announcement#create_announcement', as: :create_committee_announcement
  delete 'subcommittee_index/:committee_id/:announcement_id/delete_announcement' => 'announcement#delete_announcement', as: :delete_committee_announcement
  get 'subcommittee_index/:committee_id/edit_announcement/:announcement_id' => 'announcement#edit_announcement', as: :edit_committee_announcement
  put 'subcommittee_index/:committee_id/update_announcement/:announcement_id' => 'announcement#update_announcement', as: :update_committee_announcement
 
  get '/show_announcements' => 'announcement#show_announcements', as: :show_announcements 
  post '/search_announcements' => 'announcement#search_announcements'
  
  get 'subcommittee_index/:committee_id/new_document' => 'document_committee#new_document', as: :new_committee_document
  post 'subcommittee_index/:committee_id/create_document' => 'document_committee#create_document', as: :create_committee_document 
  delete 'subcommittee_index/:committee_id/:document_id/delete_document' => 'document_committee#delete_document', as: :delete_committee_document
  get 'subcommittee_index/:committee_id/edit_document' => 'document_committee#edit_document', as: :edit_committee_document 
  put 'subcommittee_index/:committee_id/update_document' => 'document_committee#update_document', as: :update_committee_document
  #new route created for transfer document
  get 'subcommittee_index/:committee_id/transfer_document' => 'document_committee#transfer_document', as: :transfer_committee_document
  post 'subcommittee_index/:committee_id/transfer_file_to_repository' => 'document_committee#transfer_file_to_repository', as: :transfer_file_repo
  
  get 'documents/new_file' => 'documents#new_file', as: :new_file
  post 'documents/create' => 'documents#create_file', as: :create_file
  delete 'documents/delete_file' => 'documents#delete_file', as: :delete_file
  # get 'documents/edit_file' => 'documents#edit_file', as: :edit_file
  put 'documents/edit_file' => 'documents#update_file', as: :update_file
  get 'documents/doc_info' => 'documents#info_file', as: :info_file
  post 'documents/mark_as_read' => 'documents#mark_as_read', as: :mark_as_read
  post 'documents/update_document_order' => 'documents#update_document_order', as: :update_document_order


  # Category Management
  get 'categories/index' => 'category#index', as: :category_index
  put 'categories/:id/crud_category' => 'category#crud_category', as: :crud_update_category
  delete 'categories/:id/crud_category' => 'category#crud_category', as: :crud_delete_category
  post 'categories/crud_category' => 'category#crud_category', as: :crud_create_category
  
  get 'categories/new_category' => 'category#new_category', as: :new_category
  post 'categories/create' => 'category#create_category', as: :create_category
  delete 'categories/:id/delete_category' => 'category#delete_category', as: :delete_category
  get 'categories/:id/edit_category' => 'category#edit_category', as: :edit_category
  put 'categories/:id/edit_category' => 'category#update_category', as: :update_category
  get 'categories/:id/hide_category' => 'category#hide_category', as: :hide_category
  get 'categories/:id/show_category' => 'category#show_category', as: :show_category
  get 'categories/:id/action_category' => 'category#action_category', as: :action_category
  post 'categories/update_category_order' => 'category#update_category_order', as: :update_category_order

  # Committee Management
  get 'committee' => 'committee#index', as: :committee_index
  # get 'committee/index' => 'committee#index', as: :committee_index
  put 'committee/:id/crud_committee' => 'committee#crud_committee', as: :crud_update_committee
  delete 'committee/:id/crud_committee' => 'committee#crud_committee', as: :crud_delete_committee
  post 'committee/crud_committee' => 'committee#crud_committee', as: :crud_create_committee
  
  get 'committee/new_committee' => 'committee#new_committee', as: :new_committee
  post 'committee/create' => 'committee#create_committee', as: :create_committee
  delete 'committee/:id/delete_committee' => 'committee#delete_committee', as: :delete_committee
  get 'committee/:id/edit_committee' => 'committee#edit_committee', as: :edit_committee
  put 'committee/:id/edit_committee' => 'committee#update_committee', as: :update_committee
  get 'committee/:id/hide_committee' => 'committee#hide_committee', as: :hide_committee
  get 'committee/:id/show_committee' => 'committee#show_committee', as: :show_committee
  post 'committee/update_committee_order' => 'committee#update_committee_order', as: :update_committee_order
  get 'committee/:id/inactivate_committee' => 'committee#inactivate_committee', as: :inactivate_committee
  get 'committee/:id/activate_committee' => 'committee#activate_committee', as: :activate_committee
  get 'committee/:id/action_committee' => 'committee#action_committee', as: :action_committee
  # added below route for adding/removing users from committees
  put 'committee/:id/update_committee_members' => 'committee#update_members', as: :update_committee_members
  
  # Calendar Management
  get 'calendar' => 'calendar#index', as: :calendar_index
  get 'calendar/new_calendar' => 'calendar#new_calendar', as: :new_calendar
  post 'calendar/create' => 'calendar#create_calendar', as: :create_calendar
  delete 'calendar/:id/delete_calendar' => 'calendar#delete_calendar', as: :delete_calendar
  get 'calendar/:id/edit_calendar' => 'calendar#edit_calendar', as: :edit_calendar
  put 'calendar/:id/edit_calendar' => 'calendar#update_calendar', as: :update_calendar
  get 'calendar/:id/hide_calendar' => 'calendar#hide_calendar', as: :hide_calendar
  get 'calendar/:id/show_calendar' => 'calendar#show_calendar', as: :show_calendar
  post 'calendar/update_calendar_order' => 'calendar#update_calendar_order', as: :update_calendar_order
  get 'calendar/:id/action_calendar' => 'calendar#action_calendar', as: :action_calendar

  # User Profiles
  get 'user_profiles' =>'user_profiles#index', as: :user_profiles_page
  get 'user_profiles/:id' => 'user_profiles#user_profile', as: :user_profile

  #Meeting Management
  get 'meeting' => 'meeting#index', as: :meeting_index
  put 'meeting/:id/crud_meeting' => 'meeting#crud_meeting', as: :crud_update_meeting
  delete 'meeting/:id/crud_meeting' => 'meeting#crud_meeting', as: :crud_delete_meeting
  post 'meeting/crud_meeting' => 'meeting#crud_meeting', as: :crud_create_meeting
  
  get 'meeting/new_meeting' => 'meeting#new_meeting', as: :new_meeting
  post 'meeting/create' => 'meeting#create_meeting', as: :create_meeting
  delete 'meeting/:id/delete_meeting' => 'meeting#delete_meeting', as: :delete_meeting
  get 'meeting/:id/edit_meeting' => 'meeting#edit_meeting', as: :edit_meeting
  put 'meeting/:id/edit_meeting' => 'meeting#update_meeting', as: :update_meeting
  put 'meeting/:id/edit_meeting_date' => 'meeting#update_meeting_date', as: :update_meeting_date
  put 'meeting/:id/edit_meeting_time' => 'meeting#update_meeting_time', as: :update_meeting_time
  put 'meeting/:id/edit_meeting_location' => 'meeting#update_meeting_location', as: :update_meeting_location
  put 'meeting/:id/edit_meeting_description' => 'meeting#update_meeting_description', as: :update_meeting_description
  put 'meeting/:id/edit_meeting_agenda' => 'meeting#update_meeting_agenda', as: :update_meeting_agenda
  put 'meeting/:id/edit_meeting_hangout' => 'meeting#update_meeting_hangout', as: :update_meeting_hangout
  get 'meeting/list' => 'meeting#meeting_list', as: :meeting_list
  get 'meeting/:id/show' => 'meeting#show', as: :meeting_show

  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # =>                       controller#method

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
