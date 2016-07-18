class SignIn
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :email, :password

  include ActiveModel::Validations
  validate :check_credentials

  def user
    @user ||= User.find_by(email: email)
  end

  def user_id
    user.id
  end

  def check_credentials
    if user.nil?
      errors.add(:email, "is not found.")
    else
      unless user.authenticate(password)
        errors.add(:password, "does not match.") 
      end
    end
  end

  def initialize(attrs = {})
    (attrs || {}).each do |key, value|
      send("#{key}=", value)
    end
  end

  def persisted?
    false
  end
end
