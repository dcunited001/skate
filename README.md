# Skate

This is a personal project that's been in the works for some time.  Originally, the project was written in Rails 3.0, but included a lot of bad code, from which I've since learned.  The old project is still accessible in the aptly named 'rails3oh' branch.

---

### Progress

I've starting off by testing and creating the basic models necessary for the project.  I'm close to beginning to start adding acceptance tests to help drive the development of the user interface.  I don't have all the time in the world to work on this project, but it's nice when I do.

---

### Up Next
* Finish up SqlLoader module for loading extraneous PostgreSQL scripts
* Finish up model tests for Team Requests relationship
* Set up acceptance testing
    * Acceptance testing for basic member features
    * Acceptance testing for basic admin features

## Areas of Interest:
* Friends Relationship
    * maintained with a PostgreSQL view
    * the relationship defined in friend.rb allows someone to call Member.first.friends.first.friends.last... etc
    * using PostgreSQL rules to allow for Member.first.friends.first.delete (`DELETE FROM view_friends`)
    * the above friend would instead have their corresponding friendship record inactivated
* TeamRequest/TeamMember/TeamCaptain relationships
    * designed along the same lines as the Member/Friend relationships
* SqlLoader module (db/sql_loader.rb and db/sql_loader.*)
    * tied into the Migrations for unobtrusive declaration of SQL views and rules
    * and spec_helper.rb to easily allow extra SQL objects to be created for tests

## Please Note
#### This project is PostgreSQL specific
* There are several views, rules, etc. that are defined inside (db/sql_loader.*)
* MySQL doesn't have rules to associate to views
