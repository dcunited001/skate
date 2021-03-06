DROP VIEW IF EXISTS view_friends;
CREATE VIEW view_friends AS

SELECT m.id as member_id, f.id as friendship_id, m2.*
FROM view_members_clean m
  JOIN friendships f
  ON (m.id = f.member_requested_id) OR (m.id = f.member_requesting_id)
JOIN view_members_clean m2
  ON ((f.member_requested_id = m2.id) OR (f.member_requesting_id = m2.id))
  AND (m.id != m2.id)
WHERE f.active = true;