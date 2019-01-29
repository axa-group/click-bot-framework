class PlatformsController < ApplicationController
  
  # expose Facebook webhook 
  skip_before_action :authenticate_user!, only: [:webhook, :receive_message]
  load_and_authorize_resource except: [:webhook, :receive_message]
  skip_before_action :verify_authenticity_token, only: [:webhook, :receive_message]

  skip_authorization_check only: [:index, :edit, :update, :webhook, :receive_message]

  before_action :find_platform, only: [:show, :tree, :edit, :update, :destroy, :webhook, :receive_message]

  def index
    @platforms = current_user.role == "admin" ? Platform.all : current_user.platforms
    redirect_to platform_path(@platforms.first) unless current_user.role == "admin"
  end

  def edit
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.create(platform_params)
    @platform.save
    redirect_to platforms_url, notice: "Sucessfully created '#{@platform.name}'"
  end	

  def update

    if @platform.update(platform_params)
      # reset all user sessions if decision tree was modified
      UserSession.destroy_all if @platform.decision_tree_xml_previously_changed?
      respond_to do |format|
        format.js { render 'update' }
        format.html { redirect_to platform_path(@platform), notice: "Sucessfully updated '#{@platform.name}'" }
      end
      
    else
      respond_to do |format|
        format.js { render 'edit', locals: {message: @platform.errors.full_messages.join(", ")} }
        format.html { render 'edit' }
      end
    end
  end

  def show
    @no_footer = true
  end

  def tree
    render xml: @platform.decision_tree_xml
  end

  def destroy
    name = @platform.name
    @platform.destroy

    redirect_to platforms_url, notice: "Sucessfully deleted '#{name}'"
  end

  def webhook
    if params["hub.mode"] == "subscribe" && params["hub.challenge"]
      if params["hub.verify_token"] == @platform.verify_token
        render plain: params["hub.challenge"], status: 200
      else
        render plain: "Verification token mismatch", status: 403
      end
    end
  end

  def receive_message
    Chatbot::handle_response(params, @platform)
    head :no_content
  end

  private
  def platform_params
    params.require(:platform).permit(:name, :verify_token, :access_token, :decision_tree_xml, :language_code, :threshold)
  end

  def find_platform
    @platform = Platform.find(params[:platform_id] || params[:id])
  end
end
