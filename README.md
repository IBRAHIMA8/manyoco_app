# Task
| Column name | Data type |
| --- | ----------- |
| title | string |
| content |text|
| deadline | datetime |
| status | string |
| priority | integer |
| user_id | integer |

#Deployement to Heroku
Considering that you have an account on Heroku Website

1. Firstly, you have to login on Heroku by running:

  - $ heroku Login

  - $ heroku login -i (For those who use vagrant)

2. Secondly, you have to create your Application on heroku website by taping:

  - $ heroku Create

3. The next step is to add all contain of your application on your heroku by following those step:

  - $ git add .

  - $ git commit -am "write a commit message"

  - $ git push heroku master

4. After all, run the next command to migrate your db

  - $ heroku run rails db:migrate)

5. To finish, in indor to be sure that all thing is ok, run the next command, in order to open your application in heroku
  - $ heroku open
