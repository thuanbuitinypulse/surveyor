class SurveyForm < Reform::Form
  property :title

  collection :questions do
    property :title
  end
end
