class SurveysController < ApplicationController
  def new
    build_survey
  end

  def create
    build_survey
    if @survey.save
      redirect_to edit_survey_path(@survey)
    else
      render 'new'
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title)
  end

  def build_survey
    @survey = Survey.new
  end
end
