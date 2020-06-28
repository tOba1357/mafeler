class AuthConstraint
  def self.admin?(request)
    return false unless (user_id = request.session[:user_id])
    user = User.find_by(id: user_id)
    user.present?
  end
end