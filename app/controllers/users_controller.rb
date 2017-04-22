class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    unless user_signed_in?
      flash[:notice]= "You must be signed in to see other users"
      redirect_to root_path
    end
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless @user==User.find(params[:id])
      flash[:notice]= "You can only see your own profile."
      redirect_to root_path
    end
    @user=User.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
