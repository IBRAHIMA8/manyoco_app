# el-training

## About this curriculum

This document is a curriculum for new employee education to learn the basics of Ruby on Rails and its peripheral technologies, which are essential for Manyo.
Regardless of the ability of new employees, you will be required to carry out one step.
The training period is not specified.
Training will be completed when all steps are completed.

The following characters are assumed in this curriculum.

--New employee: A student of this curriculum.
--Supporter: We provide education, guidance, and advice for new employees. It also plays the role of consulting with new employees and deciding specifications together.

It is up to the supporter's discretion to determine how much the supporter is involved in the guidance. In addition, regarding the training period, the supporters will set a guideline in advance, taking into consideration the skill level of new employees and the status of internal projects.

## Overview

### System requirements In

this curriculum, you will develop a task management system as an issue.
The task management system wants to do the following:

--I want to easily register my
task-I want to be able to set an end deadline for a task-I want
to prioritize tasks -I
want to manage status (not started / started / completed)-with  
-I want to narrow down tasks by status
task name / task description I want to search for a task
--I want to list the tasks. I want to sort on the list screen (based on priority, deadline, etc.)
-I want to classify tasks with labels, etc.-I want to
register as a user so that only the tasks I registered can be seen.

Also, the above requirements In order to meet, we would like to have the following management functions.

--User management function

### Support browser

-Support browser is assumed to be the latest version of macOS / Chrome

### Application (server) configuration

Please build using the following languages ​​and middleware () Both are the latest stable versions).

--Ruby
--Ruby on Rails --For the
PostgreSQL

server, please use the following.

--Heroku

* Performance requirements and security requirements are not specified, but please make them with general quality.
  If the response of the site is too bad, please improve it.

## Final goal of

this curriculum At the end of this curriculum, it is assumed that you will learn the following items.

--Being able to implement basic Web applications using Rails-Being able to  
-Being able to publish applications using a general environment in Rails applications
add functions and maintain data for published Rails applications
--Learn the flow of PR and merging on GitHub. Also, learn the necessary Git commands-to
  be able to commit at the right level of granularity-to be able
  to write a proper PR description-to be
  able to respond to reviews and make corrections
-to team up with unclear points at the right time You can ask questions to members and related parties (this time you will be a supporter) verbally or by chat.

## Recommended Books

In advancing the training curriculum, we recommend the following books as recommended books.

-[Ruby on Rails 5 Quick Learning Practice Guide that can be used in the field] (https://book.mynavi.jp/ec/products/detail/id=93905)

The Ruby on Rails 5 Quick Learning Practice Guide that can be used in the field is a training curriculum. The subject is the task management system as well.
Therefore, I think there are many points that can be helpful in advancing this training.

It also explains the contents that could not be covered in this training and how to proceed with team development. Please refer to it.

## A collection of topics useful for development topics

that were not included in a specific issue step, but are summarized in topics.md. Please refer to and utilize it as necessary when implementing the curriculum.

## Challenge Step

### Step 1: Build a Rails development environment

#### 1-1: Install Ruby

-Use [rbenv] (https://github.com/rbenv/rbenv) to install the latest version of Ruby-make sure the
Ruby version is displayed with the `ruby -v` command. Please

#### 1-2: Install Rails-Install

Rails with Gem command-Install the
latest version of Rails-Make sure the
`rails -v` command shows the version of Rails Please

#### 1-3: Install database (PostgreSQL) -Install Ruby

on your OS
  -For macOS, install it with `brew` etc.

### Step 2: Install the repository on GitHub Let's create

-Let's install Git at hand
  -For macOS, please install with `brew` etc. -
  Let's register user name and email address with` gitconfig`
-Let's think about application name (= repository name)
--Create a repository-
  Get it if you don't have an account-
  Create an empty repository on it

### Step 3: Create a Rails project

-First, let's cut a new topic branch with Git
  -Hereafter, we will work on the topic branch and commit
-Minimum to the application with the `rails new` command Create the directories and files you
  need-find out how to add only the bare essentials, and explain to your supporters what the rails new command does and what you plan to remove
-`rails new`. Create a directory called `docs` directly under the created project directory (the directory of the app name) and commit this document file-to keep
  the specifications of this app under control so that you can see it at any time
-version In order to clarify, let's describe the version of Ruby to be used in `Gemfile` (make sure that the version is already described for Rails) --Create a
PR on GitHub and have it
  reviewed- Let's issue PR with WIP (Work In Progress) as needed. See the topic collection for more details
  -please respond to any comments. If you have two LGTMs (Looks Good To Me), merge them into the main branch.

### Step 4: Think about the image of the application you want to create.

――Before designing, let's think about the completed image (with supporters) of what kind of app it will be. Screen design by paper prototyping is recommended
database.yml`
  --Also, think about how this app will be used (whether it will be published on the Internet, for internal use, etc ...) (with supporters)-Read the
system requirements, Think about the data structure you need-
  what kind of tables are likely to be needed, each table name, column name, data type, constraints, etc.-Let's think about the information needed to create a schema
-data structure If you think about it, let's transcribe it as a table diagram
  -take a picture when it is completed and have the supporter review it -if the supporter reviews
  it and it seems that there is no problem, the table diagram in the repository Let's put in-let's
  write the table schema in `README.md` to create a PR and have it reviewed.

* It is not necessary to create the correct table diagram at this time. Let's make it as an assumption at the moment (It is an image that we will fix it if we think it is wrong in the future step)

### Step 5: Let's set the database connection (peripheral setting)

-Let's install Bundler-
` Install `pg` (PostgreSQL database driver) with
Gemfile`-Create a database with the` rails db: create` command
-Check the connection to the database with the `rails db` command
-On GitHub Create a PR and have it reviewed

### Step 6:

Let's set up RuboCop-Set up RuboCop as Linter / Formatter
-This curriculum has been adjusted to match the Rails app creation [retrieva-cop] (https://github.com/retrieva) Use / retrievea-cop)
-Install [retrieva-cop] (https://github.com/retrieva/retrieva-cop) with `Gemfile`-
(Ask supporters) RuboCop runs when creating PR Let's set Circle CI so that it will be set
  -Because the initial setting of CI is a little out of the items you want to learn in the curriculum, please make sure that the supporter sets CI
-Since the coding standard is the supporter・ Let's update as needed in consultation with the reviewer

### Step 7: Let's create a task model Create

a CRUD to manage the task.
First of all, let's make it with a simple structure where only the name and details can be registered.

--Let's create the model class required for CRUD of the task with the `rails generate` command-  
migration and use it to create a table
  It is important to ensure that the migration can be returned to the previous state! Get in the habit of playing `redo` to check-don't
  forget to set DB constraints as well. -make
sure you can connect to the database via the model with the` rails c` command-let's
  try creating a record with ActiveRecord at this time-
set validation Let's
  -think which validation should be added to which column-
create a PR on GitHub for review

### Step 8: Allow you to view / register / update / delete tasks Let's

create a task list screen, detail screen, create screen, edit screen, and delete function.

Creating these features all at once tends to make the PR huge.
Therefore, in step 8, we will proceed with PR by dividing it into multiple parts.

Even in future steps, if the PR is likely to increase, consider whether you can issue the PR in two or more.

### Step 8-1: Let's create a task list screen and detail screen-

Let's make it possible to display the task created in step 7 on the list screen and detail screen
-Controller and view with `rails generate` command -Determine
  which template engine to use in consultation with your supporters
-Add the required implementations to your controller and view
--Edit `routes.rb` so that the task list screen is displayed at` http: // localhost: 3000 / `  
-Let's find out what HTTP is interacting with when accessing the list screen and explain it to our supporters.

### Step 8-2: Create and edit the task screen Let's create-Let's make

it possible to create and edit tasks from the screen- Let
's display a flash message on the screen after creating and updating
  -If a validation error occurs, display an error message on the screen Let's
-Create a PR on GitHub for review

### Step 8-3: Let's make it possible to delete tasks-Let's make it

possible to delete created tasks-
Flash message after deletion Let's display on the screen
-Create a PR on GitHub and have it reviewed

### Step 8-4: Let's look back

at the added code-The code added in steps 8-1 to 8-3 Let's explain to supporters
  -classes, methods, variables
  -process flow

### Step 9: Let's touch SQL

-manipulate the
  database-connect to the database with the `rails db` command Let
  's view, create, update, and delete
tasks in SQL-Access the task list screen and check that the SQL log is flowing
  SQL-Explain to your supporters what SQL is running
Let's see what SQL is executed by the method of ActiveRecord
  --Let's execute `find`,` where`, etc. with `rails c`-Let's
explain to supporters about" SQL injection "and" how to write to prevent SQL injection in Rails

## # Step 10: Write a test

-Get ready to write a
  spec-Get `spec / spec_helper.rb`,` spec / rails_helper.rb`-Write a
model spec for validation Let's -
  I don't really write much validation tests, but let's do it to get a better understanding of the model spec-let's
write a system spec for the task function
-integrate RSpec with Circle CI and do it. Let's notify Slack-
  Similar to step 6, it can be done by a supporter
-Reference book: https://leanpub.com/everydayrailsrspec-jp

### Step 11: Japanese part of the app Let's make it common

Rails' i18n mechanism, model name / attribute name and validation error message can be displayed in Japanese let's do it
  -At that time, the model added independently with [locale file provided by rails-i18] (https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/ja.yml) Let's manage the locale files

separately for ### Step 12: Set the Rails time zone

--Let's set the Rails time zone to Japan (Tokyo)

### Step 13: Sort the task list in order of creation date and time

-Currently, they are arranged in order of ID, but this is arranged in descending order of creation date and time. Let's sort
-let's write in the system spec that the sort is working well

### Step 14: Let's deploy-We now have

a simple task management system in the main branch, so deploy it Let's look at.
--Let's deploy to Heroku-
  Let's register if you don't have an account
  -The email address when registering can be either company or individual-
  Let
's touch the deployed app on Heroku- From now on, let's register the task in this app and proceed with the development-
  * However, since the Heroku application can be referenced anywhere on the Internet, let's not post information that is bad to publish
    -Basic authentication at this point It may be okay to include it-  
  -in the future, continue to deploy your app to Heroku after each step
let's describe the deployment method in `README.md`
  -at that time, it is better to include the version information of the framework used in this app etc.

## # Step 15: Let's add an expiration

date-Let's register an expiration date for a task
-Let's sort by expiration date on the list screen
expand the spec-let's
release it after PR and review

### Step 16: Add status to make it searchable

-Status (not started / started / in progress / in progress / Let's add (done)
  -[Option] If you are not a beginner, you can introduce a Gem that manages the state
-Let's make it possible to search by title and status on the list screen-
  [Option ] ] If you are not a beginner, you may introduce a gem that makes it convenient to implement search such as ransack-
when narrowing down, let's check the change of issued SQL by looking at the log
  -afterwards Let's get in the habit of checking as needed even in the step of
-Let's paste the search index-
  Prepare a certain amount of test data and check the operation while looking at log / development.log, and adding the index will speed up Let's check that it will be improved-
  [Option] Let's see the index usage on the database side using PostgreSQL explain etc.-Let's
add a model spec to the search ( Let's expand the system spec as well)

### Step 17: Let's set the priority (* If you have similar implementation experience, you can omit

it) --You can register the priority (high, medium, low) for the task. Let's-let's
be able to sort by priority
--Let's expand the system spec-Let's
release it after PR and review (Please continue)

### Step 18: Let's add

a pagenation-List screen using a gem called Kaminari Let's add a pagenation to

### Step 19: Let

's guess the design-Introduce Bootstrap and apply the design to the apps you have created so far-
  [Option] Write and design your own CSS

### Step 20:

Let's create a user model-Let's create a user model-Let's create the
first user with seed-Make sure that
the first user created with seed and the task are linked. Let's -Put
  an index for related-
  * When deploying to Heroku, make sure that the already registered task and user are linked (data maintenance)

### Step 21: Login / Logout Let's implement the function

-Let's implement it by ourselves without using additional  
  -Gem such as Devise By not using it, the purpose is to deepen the understanding of the mechanism such as HTTP Cookie and Session in Rails.
  gems-It also aims to deepen the understanding of general authentication (such as password handling)-Implement the
login screen Let's
-If you're not logged in, don't go to the task management page
--When you create a task, let's associate the task with the logged-in user-Let's
display only the task created by you
-Implement the logout function

### Step 22: User's Let's implement the management screen -

Let's add the management menu on the
screen-Be sure to prefix the management screen with the URL `/ admin`
  -Before adding it to` routes.rb`, the URL and Let's design assuming a routing name (name that becomes `* _path`)-Implement
user list / create / update / delete-After
deleting a user, delete the task that the user has. Let's do it -Let's
show the number of tasks the user has on the user list screen-Let's
  implement a mechanism to avoid the N + 1 problem-
Created by the user Let's make the list of tasks visible

### Step 23: Add roles to users-Let

users distinguish between administrative and general users
-Only admin users will be on the user admin screen Let's make it accessible
's make the role selectable in the user management screen
  -if a general user accesses the management screen, make a special exception Let's look at
  --Catch the exception and display the error page properly (you can do it in step 25) --Control
the deletion so that no one of the admin users is gone
  -Call back the model Let's
use it-* You can use or not use Gem freely

### Step 24: Let's make it possible to label tasks-Let's make it possible to
attach

multiple labels to tasks- Let's make it searchable by label

### Step 25: Set the error page properly-Let's make

the default error page provided by Rails your own screen
-depending on the situation , Let's set the error page properly-
  at least two types of status code settings, page 404 and page 500, are required.

## Postscript Thank you for your

hard work.
You have completed the entire educational curriculum !!

I couldn't cover it in this curriculum, but I think that the following topics will be needed in the future, so I think it is good to proceed with learning (learning through projects). I think there are many).

--Deepen a basic understanding of web applications-
  Understanding HTTP and HTTPS
-Learn a little more advanced use of Rails
  -STI
  -Logging
  --Explicit transactions- A better  
  -Asynchronous processing
  -Asset pipeline (rather a release topic)
understanding of frontends such as JavaScript and CSS-A better understanding
of databases
  -SQL
  -Building more performance-focused queries-A
  better understanding of indexes-A greater understanding of
server environments --Linux
  OS
  --Web server (Nginx) settings
  -Application server (Unicorn) settings
  -Understanding PostgreSQL settings-Understanding
release tools
  -Capistrano
  --Ansible
