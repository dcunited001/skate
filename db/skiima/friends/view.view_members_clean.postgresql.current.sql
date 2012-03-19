DROP VIEW IF EXISTS view_friends;
CREATE VIEW view_members_clean AS

SELECT
  id,
  email,
  sign_in_count,
  current_sign_in_at,
  last_sign_in_at,
  current_sign_in_ip,
  last_sign_in_ip,
  created_at,
  updated_at,
  alias,
  first_name,
  last_name,
  rink_id,
  birthday,
  phone,
  verified,
  original_verified_date,
  last_verified_date,
  current_member,
  original_membership_date,
  last_membership_date,
  renewal_months,
  pro_skater,
  suspended,
  suspended_until
FROM members;