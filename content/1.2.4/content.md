---
type: written content
name: Sequelize and CI
author: Ben White
time: 60

---

Working with Sequelize, our process for CI and automatic deployment to Heroku will be similar to the one we used for Mongoose. We'll need to configure Travis, create a new Heroku instance, create a new database on ElephantSQL, point our production app on Heroku to this database, and run our initial migration scripts. In this assignment, we'll walk through that process.

Your starting point for this assignment should be the repo you created in the previous assignment. If you were unable to complete that assignment, copy over the `./routes/grades.js` file from [the solution branch](https://github.com/Thinkful-Ed/node-restaurants-sequelize-tests/tree/feature/solution).

## Set Up Travis

The first thing we'll need to do is add a `.travis.yml` file to our repo, and add the repo to Travis-CI.org.

In the root of the restaurants app folder, create a new file called `.travis.yml` and paste in the following code:

```yaml
language: node_js
node_js: node
services:
- postgres
before_script:
- psql -c 'create database "test-restaurants-app";' -U postgres
```

This tells Travis we have a Node app that uses the Postgres service. The `before_script` entry tells Travis to create a database called "test-restaurants-app" for the "postgres" user before running our tests. Travis will create this database locally. Note that the database name we've chosen here corresponds to the default value we've set for the test db in our `config.js` file.

Save and commit these changes locally, but hold off on pushing to GitHub. Before doing that, we need to go through the setup steps to turn on TravisCI for the repo.

To do this, first go to your forked repo on GitHub. Next, click Settings => Integrations & Services. Now, type and select TravisCI.

After you do that, go to your [TravisCI dashboard](https://travis-ci.org/), click the icon for your profile in the top right corner, and then turn on the switch for the restaurants app repo.

With that, Travis is configured to run our tests when we push to this GitHub repo. Now we can push our local changes up to GitHub, which will trigger TravisCI to run tests whenever we push changes.

Back in your browser, refresh your dashboard on TravisCI. It may take about 30 seconds to show up, but soon you should see your tests run for this repo. If all goes well, you'll see in the dashboard's logs that your tests ran and passed.


## Deploying to Heroku

To configure Travis to work with Heroku, we'll start [the same process we learned about earlier](/node-001v5/uuid/b95a1e80-b352-11e6-9f19-5372cdc944dc).

From our repo, on the command line, run `travis setup heroku`. You can hit "Return" for each of the prompts. After this routine has run, a quick `git diff` will reveal that Travis CLI made changes to `.travis.yml`. If you open that file, you'll see that a deploy block has been added.

Next, we need to create an app on Heroku that we can deploy to. From the command line, run `heroku create` to create a new Heroku app with a randomly generated name. Copy the new app name and paste it in for the `deploy:app:` setting in `.travis.yml`.

Save, then commit your changes to `.travis.yml` to master, and push up to GitHub.

If you visit TravisCI in your browser and go to the node-shopping-list-integration-tests project, your tests should be running or waiting in a queue. This time, after the tests pass, TravisCI will attempt to publish your app to Heroku.

If all goes well, you'll be able to visit a live version of the app at your-heroku-app-name.herokuapp.com/. However, since we haven't set up our database, if you make a request to the app it will fail.

## Configure the database

Now we need to create a new database on ElephantSQL, run migrations on that database, and then point our Heroku app to the right database URL.

To create a database on ElephantSQL, follow the same steps from the previous lesson. Copy the database URL. Then, in Heroku, add a config var to your app called `DATABASE_URL`, pasting in the URL for the value. This will trigger Heroku to rebuild your app.

Now, we just need to run our migration. From the command line, run the command `psql -f ./migrations/migrations/0001_restaurants_and_grades_initial.sql postgres://<elephant-sql-db-url>`. This will create the tables required by our models in the database.

Now, when you visit the `/restaurants` URL for your app, you should get back a JSON object that looks like this:

```json
{
    "restaurants": []
}
```

Since we haven't added any restaurants to the database, the array of restaurants is empty, but this tells us that our app is configured correctly.

