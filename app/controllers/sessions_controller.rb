class SessionsController < ApplicationController
  
  skip_before_filter :login_required
  
  def new
    redirect_to root_path if session[:user]
  end
  
  def login
    if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
      redirect_to(session[:return_to] || root_path)
    else
      flash.now[:error] = "Nepareizs lietotājvārds vai parole!"
      render :action => "new"
    end
  end

  def logout
    session[:user] = nil
    session[:return_to] = nil
    redirect_to :action => "login"
  end
    
end