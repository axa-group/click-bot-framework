class Admin::OffTopicsController < ApplicationController

	before_action :find_off_topic, only: [:edit, :update, :destroy]
	
	def index
		@off_topics = OffTopic.all
	end

	def edit
	end

	def new
		@off_topic = OffTopic.new
		@off_topic.training_messages.build
	end

	def create
		@off_topic = OffTopic.create(off_topic_params)
    if @off_topic.save
      redirect_to admin_off_topics_url, notice: "Sucessfully created '#{@off_topic.name}'"
    else
      render 'new'
    end

	end

	def update
		if @off_topic.update(off_topic_params)
      redirect_to admin_off_topics_path, notice: "Sucessfully updated '#{@off_topic.name}'"
    else
      render 'edit'
    end
	end

	def destroy
    @off_topic.destroy
    redirect_to admin_off_topics_url, notice: "Sucessfully deleted off topic"
	end

	def train
		TrainClassifierJob.perform_later current_user.id
	end

	private

  def off_topic_params
    params.require(:off_topic).permit(:name, :response, :language_code, :action_hook, :confirmation, training_messages_attributes: [:id, :text, :off_topic_id, :_destroy])
  end

  def find_off_topic
    @off_topic = OffTopic.find(params[:id])
  end

end
