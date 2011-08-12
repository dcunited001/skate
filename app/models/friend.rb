class Friend < Member
  set_table_name 'view_friends'

  attr_accessible :id, :member_id

  def friends
    super #it's ssssuper, thanks for asking
  end

  def == (member)
    id == member.id
    #eql?(friend)
    #super if friend.is_a? Member
  end
end

