class Survey < ApplicationRecord
  validates :title, presence: true
  has_many :questions
end
