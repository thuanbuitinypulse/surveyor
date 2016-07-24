class Response < ApplicationRecord
  belongs_to :survey
  validates :survey, presence: true
  has_many :answers, dependent: :destroy
end
