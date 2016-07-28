class Collaboration < ApplicationRecord
  belongs_to :survey
  belongs_to :user

  validates :survey, :user, :role, presence: true
  enum role: { owner: 0, editor: 1, viewer: 2 }
  validates :role, inclusion: {in: roles.keys }
  validates :role, uniqueness: {scope: :user_id, message: "already exists for user"}

  def email
    user.try(:email)
  end
end
