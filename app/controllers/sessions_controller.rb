class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(username:params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id #cookies has size-limitation. dont save the object
      flash[:notice] = 'You have successfully logged in. '
      redirect_to root_path    
    else
      flash.now[:error] = 'There is something wrong with your username or password'
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out. '
    redirect_to root_path
  end
  
end