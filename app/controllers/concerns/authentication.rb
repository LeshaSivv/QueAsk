module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      if session[:user_id].present?
        @current_user ||= User.find_by(id: session[:user_id]).decorate
      elsif cookies.encrypted[:user_id].present?
        user = User.find_by(id: cookies.encrypted[:user_id])
        if user&.remember_token_authenticated?(cookies.encrypted[:remember_token])
          sign_in(user)
          current_user ||= user.decorate
        end
      end
    end
  
    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out(current_user)
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def remember(user)
      user.remember_me
      cookies.encrypted.permanent[:remember_token] = user.remember_token
      cookies.encrypted.permanent[:user_id] = user.id
    end

    def forget(user)
      user.forget_me
      cookies.delete(:remember_token) if cookies[:remember_token].present?
      cookies.delete(:user_id) if cookies[:user_id].present?
    end

    def require_current_user
      return if user_signed_in?

      flash[:warning] = 'You already signed in!'
      redirect_to root_path
    end

    def require_no_current_user
      return unless user_signed_in?

      flash[:warning] = 'You already signed in!'
      redirect_to root_path
    end

    helper_method :current_user, :user_signed_in?
  end
end