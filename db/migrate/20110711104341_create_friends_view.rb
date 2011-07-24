class CreateFriendsView < ActiveRecord::Migration
  def self.up

    execute('
CREATE VIEW v_friends AS

SELECT m.id as member_id, m2.*
FROM devise m
  JOIN friendships f
  ON (m.id = f.member_requested_id) OR (m.id = f.member_requesting_id)
JOIN devise m2
  ON ((f.member_requested_id = m2.id) OR (f.member_requesting_id = m2.id))
  AND (m.id != m2.id)
WHERE f.active = true')
  end

  def self.down
    execute('
DROP VIEW v_friends')
  end
end
