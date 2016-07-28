class AnswerForm < Reform::Form
  validates :content, :choice_id, :question_id, presence: true

  property :content
  property :choice_id
  property :question_id

  def question
    model.question
  end

  def choice
    model.choice
  end
end
