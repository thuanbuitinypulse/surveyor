class User < ApplicationRecord
  has_many :collaborations
  has_many :surveys, through: :collaborations

  has_secure_password
  validates :email, presence: true

  def role
    admin? ? 'admin' : 'user'
  end
end
