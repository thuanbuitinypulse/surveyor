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

  def edit
    load_survey
  end

  def update
    load_survey
    if @survey.validate survey_params
      @survey.save
      redirect_to edit_survey_path, notice: "Saved."
    else
      render 'edit'
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title, :questions) if params[:survey]
  end

  def build_survey
    survey = Survey.new survey_params
    @survey = SurveyForm.new survey
  end

  def load_survey
    survey = Survey.find params[:id]
    @survey = SurveyForm.new survey
  end
end
