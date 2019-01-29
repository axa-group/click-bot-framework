class Admin::UserSessionsController < ApplicationController
	def index
    @user_sessions = UserSession.all.order("created_at DESC")
	end
  def destroy
  	@user_session = UserSession.find(params[:id])
  	@user_session.destroy
  	redirect_to admin_user_sessions_path
  end
end
