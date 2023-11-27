class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params).decorate
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to QueAsk, #{@user.name_or_email}"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def index
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end
end
