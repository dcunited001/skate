### Ideas for Postgres Objects
#### need to limit data returned by views (especially views with member data)

---

#### Friends
* check constraints to reconcile foreign keys w/ polymorphism
* mutual friends view
* friends materialized view
    * unmaterialized view
    * target table
    * refresh function
    * invalidation function
    * expiry function
    * triggers
    * reconciler view

#### Members
* view of members without private devise data
* function to determine whether a member is a captain ??

#### Rinks
* mutual members view

#### Teams
* team captains view
* member teams view (with history)   (member has_many :teams)    ??
* member current team view           (member has_one :team)    ??

#### Team Requests

