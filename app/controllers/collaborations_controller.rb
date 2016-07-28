class CollaborationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_owner!

  def index
    current_survey
    @collaboration = Collaboration.new(survey: current_survey)
  end

  def create
    @collaboration = Collaboration.new(collaboration_params)
    @collaboration.survey = current_survey
    if @collaboration.save
      redirect_to survey_collaborations_path(current_survey)
    end
  end

  private
  def authenticate_owner!
    if current_survey.users.find(current_user).blank?
      render plain: 'Access Denied.', status: 403
    end
  end

  def current_survey
    @survey ||= Survey.find(params[:survey_id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :role)
  end
end
