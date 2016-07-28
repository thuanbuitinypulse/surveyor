class SurveyForm < Reform::Form
  property :title
  validates :title, presence: true

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

  def save(user)
    super

    if self.model.users.blank?
      collaboration = Collaboration.create(survey: self.model, user: user)
      collaboration.owner!
    end
  end
end
