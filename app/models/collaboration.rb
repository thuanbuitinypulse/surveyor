class Collaboration < ApplicationRecord
  belongs_to :survey
  belongs_to :user

  validates :survey, :user, :role, presence: true
  enum role: { owner: 0, editor: 1, viewer: 2 }
  validates :role, inclusion: {in: roles.keys }

  def email
    user.try(:email)
  end

  def admin(survey, user)
    where(survey: survey, user: user).first
  end

  def viewer?
    self.role == "viewer"
  end
end
