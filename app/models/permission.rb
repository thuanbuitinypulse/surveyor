class Permission < Struct.new(:user)
  def allow?
    if user.admin?
      true
    end
  end
end
