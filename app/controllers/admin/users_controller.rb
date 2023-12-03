class Admin::UsersController < ApplicationController
  before_action :require_current_user

  def index
    respond_to do |format|
      format.html do
        @pagy, @users = pagy User.order(created_at: :desc)
      end

      format.zip do
        response_with_zipped_users
      end
    end
  end

  def create
    if params[:archive].present?
      UserService.call params[:archive]
      flash[:success] = 'Users imported!'
    end

    redirect_to admin_users_path
  end

  private 

  def response_with_zipped_users
    Zip.force_entry_names_encoding = 'UTF-8'
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user#{user.id}.xlsx"
        zos.print render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx],
          template: 'admin/users/user',
          locals: {user: user}
        )
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: 'users.zip'
  end
end
