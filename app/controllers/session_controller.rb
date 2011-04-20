class SessionController < ApplicationController
  
  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Autorizācija veiksmīga!"
        redirect_to_stored
      else
        flash[:warning] = "Autorizācija neveiksmīga!"
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => "login"
  end
    
end