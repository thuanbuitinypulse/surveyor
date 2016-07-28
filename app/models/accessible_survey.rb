class AccessibleSurvey < Struct.new(:user)
  def all
    return [] unless user
    if user.admin?
      Survey.all
    else
      Survey.where(id: Collaboration.where(user: user).pluck(:survey_id))
    end
  end
end
