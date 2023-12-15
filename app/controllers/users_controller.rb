class UsersController < ApplicationController
  before_action :require_no_current_user, only: %i[new create]
  before_action :require_current_user, only: %i[show destroy edit update]
  before_action :set_user, only: %i[edit show update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params).decorate
    if @user.save
      sign_in(@user)
      flash[:success] = t('.success', name: @user.name_or_email)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end


  def index
  end


  private

  def set_user
    @user = User.find(params[:id]).decorate
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email, :old_password)
  end
end
