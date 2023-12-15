class SessionsController < ApplicationController
  before_action :require_no_current_user, only: %i[new create]
  before_action :require_current_user, only: :destroy

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      sign_in(@user)
      remember(@user) if params[:remember_me] == '1'
      @user = @user.decorate
      flash[:success] = t('.success', name: @user.name_or_email)
      redirect_to root_path
    else
      flash[:warning] = t('.invalid_creds')
      redirect_to new_session_path
    end
  end

  def destroy
    flash[:success] = t('.success')
    sign_out(current_user)
    redirect_to root_path
  end
end
