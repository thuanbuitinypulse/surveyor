class ResponsesController < ApplicationController
  def index
    load_survey
  end

  def new
    load_survey
  end

  def create
    load_survey
    @response = @survey.responses.build response_params
    if @response.save
      redirect_to edit_survey_response_path(@survey, @response)
    else
      render 'new', notice: "Please correct errors below."
    end
  end

  def edit
    load_survey
    response = Response.find params[:id]
    @form = ResponseForm.new(response)
    @form.prepopulate!
  end

  def update
    load_survey
    response = Response.find params[:id]
    @form = ResponseForm.new(response)
    if @form.validate response_params
      @form.save
      redirect_to edit_survey_response_path(@form.survey, @form), notice: "Saved."
    else
      @form.prepopulate!
      render 'redit'
    end
  end

  private
  def load_survey
    @survey = Survey.find params[:survey_id]
  end

  def response_params
    params.require(:response).permit(answers_attributes: [:id, :question_id, :choice_id, :content]) if params[:response]
  end
end
