class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to root_path
    else
      flash[:warning] = 'Incorrect email and/or password'
      redirect_to new_session_path
    end
  end

  def destroy
  end
end
