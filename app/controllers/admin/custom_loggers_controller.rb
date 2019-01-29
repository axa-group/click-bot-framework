class Admin::CustomLoggersController < ApplicationController
	def index
    @custom_loggers = CustomLogger.all.order("created_at DESC")
	end

	def show
    @custom_logger = CustomLogger.find(params[:id])
	end
end
