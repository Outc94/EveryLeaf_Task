
Users
-----

column | data_type
-------|---------
id | integer
first_name | text
last_name | text
email | text
password | text
timestamp | datetime


Tasks
-----

column | data_type
-------|---------
id | integer
title | text
content | text
user_id | integer
timestamp | datetime


Labels
------

column | data_type
-------|---------
id | integer
label_name | text
task_id | integer
timestamp | datetime

# Deployment Procedure to heroku
1. git add -A: Since Heroku uses Git to deploy, we need to commit first
2. git commit -m "init: Use git commit command to commit"
3. Heroku create: to create a new application to heroku
4. git push heroku master: to push and deploy to heroku
5. heroku run rake db:migrate: execute migration manually
