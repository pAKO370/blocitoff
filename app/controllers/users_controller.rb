class UsersController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def index
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    authorize @user
    # unless current_user
    #   redirect_to new_user_session_path
    # end
  end
  def user_not_authorized
    flash.now[:alert] = "You are not authorized to view this page!"
    redirect_to profile_path
  end

end
