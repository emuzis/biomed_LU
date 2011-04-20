class SessionsController < ApplicationController
  
  before_filter 
  
  def new
  end
  
  def login
    if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
      redirect_to :action => session[:return_to]
    else
      flash.now[:error] = "Nepareizs lietotājvārds vai parole!"
      render :action => "new"
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => "login"
  end
    
end