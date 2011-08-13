class Admin < Member
  # to be implemented

  after_create :add_appadmin_role

  private
  def add_appadmin_role
    assign_role(:appadmin)
  end
end