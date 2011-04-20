class SessionsController < ApplicationController
  
  before_filter 
  
  def new
  end
  
  def login
    if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
      flash[:message]  = "Autorizācija veiksmīga!"
      redirect_to :action => session[:return_to]
    else
      flash[:error] = "Autorizācija neveiksmīga!"
      render :action => "new"
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => "login"
  end
    
end