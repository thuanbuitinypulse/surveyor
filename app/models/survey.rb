class Survey < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :title, presence: true
end
