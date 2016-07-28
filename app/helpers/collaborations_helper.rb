module CollaborationsHelper
  def options_for_user
    User.where.not(id: current_user.id).map{|e| [e.email, e.id]}
  end
end
