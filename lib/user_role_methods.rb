module UserRoleMethods

  def admin?
    self.roles.where(name: "admin").present?
  end

end
