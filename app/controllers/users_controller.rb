class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :upadte]
  before_action :require_same_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'You are registered.'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile are updated. '
      redirect_to root_path
    else
      render :update
    end 
  end

  private

  def user_params 
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end



end