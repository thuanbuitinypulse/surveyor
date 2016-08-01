class SurveyForm < Reform::Form
  property :title
  validates :title, presence: true
  delegate :create_owner!, to: :model

  collection :questions,
    skip_if: :skip_blank_questions,
    form: QuestionForm,
    prepopulator: :set_up_questions,
    populate_if_empty: Question

  def skip_blank_questions(options)
    options[:fragment]['title'].blank?
  end

  def set_up_questions(options)
    self.questions << Question.new if questions.size < 1
  end
end
