class UsersController < ApplicationController
  before_action :require_user_login, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created!"
      session[:user_id] = @user.id
      redirect_to affirmations_path
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:info] = "Your profile has been updated!"
      redirect_to affirmations_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    access_denied if current_user != @user
  end

end