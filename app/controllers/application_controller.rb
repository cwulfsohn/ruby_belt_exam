class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :login_user

  def login_user
    unless session[:id]
      redirect_to '/main'
    end
  end
end
