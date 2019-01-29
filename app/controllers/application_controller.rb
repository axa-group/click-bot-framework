class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action do |controller|
    flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice]
  end

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
