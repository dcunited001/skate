
select t.name, CONCAT(r.first_name, ' ', r.last_name) as `FROM`, CONCAT(m.first_name,' ', m.last_name) as `TO`, tm.* 
from testapp_dev.team_members tm 
inner join testapp_dev.teams t on t.id = tm.team_id
inner join testapp_dev.members m on m.id = tm.member_id
inner join testapp_dev.members r on r.id = tm.requestor_id

order by t.name, m.first_name, r.first_name;

SELECT `team_members`.* FROM `team_members` WHERE (`team_members`.member_id = 3 AND ((approved = false and rejected = false)));