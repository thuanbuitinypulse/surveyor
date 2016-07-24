class Response < ApplicationRecord
  belongs_to :survey
  validates :survey, presence: true
  has_many :answers, dependent: :destroy

  def answers_for(question:, choice:)
    if filter = grouped_answers[question.id]
      filter.select{|e| e.choice == choice}
    end || []
  end

  def grouped_answers
    return @grouped_answers if @grouped_answers
    @grouped_answers = answers.group_by(&:question_id)
  end
end
