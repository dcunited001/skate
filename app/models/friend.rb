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


# SET UP "ON DELETE DO INSTEAD" RULES ON THE VIEW IN THE MIGRATIONS
#  http://fawcett.blogspot.com/2008/02/postgresql-love-deleting-from-views.html

# E.G.
# CREATE RULE v_friends_delete AS ON DELETE TO v_friends
# DO INSTEAD UPDATE friendships SET active = 0 WHERE id = OLD.friendship_id

# (need to add friendships.id to the view as well)