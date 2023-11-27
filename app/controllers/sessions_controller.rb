class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email]).decorate
    if user&.authenticate(params[:password])
      sign_in(user)
      flash[:success] = "Welcome back, #{user.name_or_email}"
      redirect_to root_path
    else
      flash[:warning] = 'Incorrect email and/or password'
      redirect_to new_session_path
    end
  end

  def destroy
    flash[:success] = "See you later"
    sign_out
    redirect_to root_path
  end
end
