class Choice < ApplicationRecord
  belongs_to :question
  delegate :survey, to: :question
end
