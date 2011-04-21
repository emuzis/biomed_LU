class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_required
    if session[:user]
      return true
    end
    flash[:warning] = "Lūdzu autorizējaties, lai turpinātu!"
    session[:return_to] = request.request_uri
    redirect_to login_path
    return false 
  end

  def current_user
    session[:user]
  end
  helper_method :current_user
  
end
