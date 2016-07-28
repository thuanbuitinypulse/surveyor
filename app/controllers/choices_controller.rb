class ChoicesController < ApplicationController
  def destroy
    choice = Choice.find params[:id]
    survey = choice.survey
    choice.destroy
    redirect_to edit_survey_path(survey)
  end
end
