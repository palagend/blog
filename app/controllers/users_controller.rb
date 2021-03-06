# coding: utf-8
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :currect_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def edit
    @user = User.find params[:id]
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:danger] = '密码不一致'
      render 'new'
      return
    end
    if @user.save
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_later
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in first.'
      redirect_to login_url
    end
  end

  def currect_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    if !current_user.admin?
      flash[:danger] = 'Forbidden'
      redirect_to(root_url)
    end
  end
end
