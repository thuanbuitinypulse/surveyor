class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def index
    load_survey
    @collaboration = Collaboration.new
  end

  def create
    load_survey
    @collaboration = Collaboration.new collaboration_params
    @collaboration.survey = @survey
    if @collaboration.save
      redirect_to survey_collaborations_path(@survey), alert: "Added #{@collaboration.email}"
    else
      flash.now[:error] = "Error: #{@collaboration.errors.full_messages.to_sentence}"
      render 'index'
    end
  end

  def destroy
    @collaboration = Collaboration.find params[:id]
    @collaboration.destroy
    redirect_to survey_collaborations_path(@collaboration.survey_id)
  end

  private
  def load_survey
    @survey = Survey.find params[:survey_id]
  end

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :role)
  end
end
