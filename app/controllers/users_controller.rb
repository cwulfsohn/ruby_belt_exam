class UsersController < ApplicationController
  skip_before_action :login_user, only: [:new, :create, :login]
  def new
  end

  def show
    @user = User.find(params[:id])
    @playlist_song = Playlist.where(user_id: params[:id])
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:id] = user.id
      session[:first_name] = user.first_name
      session[:last_name] = user.last_name
      redirect_to '/songs'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/main'
    end
  end

  def login
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    puts user.inspect
    if user
      session[:id] = user.id
      session[:first_name] = user.first_name
      session[:last_name] = user.last_name
      redirect_to '/songs'
    else
      redirect_to '/main', alert: "User does not exist"
    end
  end

  def logout
    session.clear
    redirect_to '/main'
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
