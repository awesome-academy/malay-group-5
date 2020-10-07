class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find(params[:id])
    return if @user

    flash[:danger] = "Error"
    redirect_to @user
  end
    
  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Let's start your course registration"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
    if @user.edit user_params
      flash.now[:success] = "User found"
      render :edit
    else
      flash[:danger] = "User not found"
      redirect_to root_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      else
        render :edit
      end 
    end

    def destroy
      User.find_by params[:id].destroy
      flash[:success] = "User is deleted"
      redirect_to users_url
    end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end 
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
