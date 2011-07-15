class Friend < Member
  set_table_name 'v_friends'

  #how to get your friend's friends ?
  #has_many :friends, :foreign_key => 'member_id'

  def friends
    super #it's ssssuper, thanks for asking
  end

  def == (friend)
    id == friend.id
    #eql?(friend)
    #super if friend.is_a? Member
  end
end