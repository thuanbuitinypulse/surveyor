class Survey < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :collaborations, dependent: :destroy

  validates :title, presence: true

  def responses_count
    responses.size
  end

  def last_response_at
    responses.order(updated_at: :desc).first.try(:updated_at)
  end

  def create_owner!(user)
    collaborations.create! user: user, role: :owner
  end

  def allow_collaboration?(user, action)
    if role = collaborations.find_by(user: user).try(:role)
      Collaboration::SURVEY_ACTIONS[role.to_sym].include?(action)
    end
  end

  def generate_response
    response = self.responses.create

    self.questions.each do |question|
      case question.type.to_sym
        when :short_answer
          response.answers.create question: question, content: %w(Thuan Harley An Thanh).sample
        when :multiple_choice
          choice = question.choices.sample
          response.answers.create question: question, choice: choice, content: choice.content
        when :check_boxes
          question.choices.each do |choice|
            if rand(2) == 0
              response.answers.create question: question, choice: choice, content: choice.content
            end
          end
      end
    end

    self.save
  end
end
