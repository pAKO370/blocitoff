class UsersController < ApplicationController
  def index
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    # unless current_user
    #   redirect_to new_user_session_path
    # end
  end
end
