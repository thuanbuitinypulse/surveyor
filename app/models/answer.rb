class Answer < ApplicationRecord
  belongs_to :choice
  belongs_to :question
  belongs_to :response

  validates :response, :question, :choice, presence: true
end
