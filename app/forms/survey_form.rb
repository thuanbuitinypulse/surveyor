class SurveyForm < Reform::Form
  property :title
  validates :title, presence: true

  collection :questions, skip_if: :skip_blank_questions, populate_if_empty: Question do
    property :title
    property :type
    validates :title, :type, presence: true
  end

  def skip_blank_questions(options)
    options[:fragment]['title'].blank?
  end
end
