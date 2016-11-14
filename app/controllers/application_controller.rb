class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "login"
  
  # by Tony
  # redirecting to the dashboard after authentication
  def after_sign_in_path_for(resource)
    '/dashboard#index'
  end  


  # by Tony
  # redirecting a new session to a sign in
  # if logged in, redirect to the dash board
  def authenticate
    if user_signed_in?
      user_id = current_user.id
      redirect_to("/dashboard#index")
    else
      flash[:message] = "Please sign in to continue"
      redirect_to("/users/sign_in")
    end
  end
  
end
