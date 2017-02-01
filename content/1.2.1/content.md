---
type: written content
name: First steps with Sequelize
author: Ben White
time: 60

---

In this assignment, we'll look at a simple polling app that uses Sequelize in order to learn the basics of organizing a Sequelize app.

One quick note: although Sequelize is currently the most popular SQL-based ORM for Node, in comparison to ORMs for other popular languages (for instance, Ruby's Active Record or Python's SQLAlchemy), Sequelize is less mature and has a number of quirks. We'll point these out as we go along.


## Our polling app

Our app provides API endpoints for polls. A poll consists of a name, question, and a tally of yes and no votes. So for instance, you might have a poll called "ES5 vs. ES6" that asks, "Do you mainly code in ES5 or ES6?"

Below, you'll find a live version of our polling app running on Gomix. This app is connected to an ElephantSQL database that has been seeded with fake data so we can make requests and get something back.

<iframe src="https://gomix.com/#!/project/node-minimal-express-sequelize-app" width="100%" height="600px"></iframe>

We'll dive into the code in a moment, but first take a moment to make some requests to the app using Postman, as we've done in previous assignments. Make a GET request to `https://node-minimal-express-sequelize-app.gomix.me/polls`, and you'll get back all polls from the database.

After you make the request, have a look at the logs inside the Gomix instance. You should see a line that looks something like this:

```
Executing (default): SELECT "id", "name", "question", "yes_votes" AS "yesVotes", "no_votes" AS "noVotes", "created_at", "updated_at" FROM "polls" AS "poll";
```

By default, Sequelize logs out each SQL command it sends to the database.

Feel free to also experiment with the other endpoints (`GET /polls/:id`, `POST /polls`, `PUT /polls/:id`).

As you can see, our API represents polls using JSON objects that look like this:

```json
{
    "id": 1,
    "name": "odit provident molestias",
    "question": "tenetur officiis officia",
    "yesVotes": 5,
    "noVotes": 5,
    "created_at": "2017-01-18T21:24:36.173Z",
    "updated_at": "2017-01-18T21:24:36.173Z"
},
```

We get back `id`, `name`, `question`, `yesVotes`, `noVotes`, `created_at`, and `updated_at` properties. If you're wondering about the combination of snake case (`foo_bar`) and camel case (`fooBar`) here, don't worry. This stems from one of Sequelize's quirks, and we'll explain it a bit later.

For the remainder of this assignment, you can follow along using the Gomix above, or you can clone [this repo](https://github.com/Thinkful-Ed/node-minimal-sequelize-app) and walk through the code in your text editor.

## Connecting to the database

In the Mongoose-backed apps we worked with earlier in this unit, you may recall that we had a `runServer` function that called `mongoose.connect` to connect to a Mongo database.

In Sequelize apps we also need to connect to the database, but this happens *implicitly* (arguably another of Sequelize's quirks). Let's see what this means.

Inside of `server.js`, we have the following code:

```javascript
// ...
const app = require('./app');
// ...

function runServer(port) {
  return new Promise((resolve, reject) => {
    try {
      server = app.listen(port, () => {
        console.log(`App listening on port ${port}`);
        resolve();
      });
    }
    catch (err) {
      console.error(`Can't start server: ${err}`);
      reject(err);
    }
  });
}
```

At first glance, it looks like we're not connecting to the database. However, upon further inspection we can see how this happens via a series of imports. Fair warning: we're going to have to follow a chain of imports here to understand how database connection happens.

Our `server.js` module imports `app` from `app.js`. Having a look at `app.js`, on line 10, we import our `Poll` model (`const {Poll} = require('./models');`).

In turn, looking at `./models/index.js`, we see that we've defined a module that imports all of our models for this app (in this instance, only a single one) and exposes them to other modules. If `./models/index.js` looks mysterious, don't worry; we'll come back and explain it in the next section on defining models. For now, we're interested in line 15 `const {Poll} = require('./poll');`.

Looking at the very top of `./models/poll.js`, at line 10, we have `const {sequelize} = require('../db/sequelize');`.

Finally, taking a look at `./db/sequelize.js`, we find the code that initially connects to the database.

```javascript
const Sequelize = require('sequelize');
const {DATABASE_URL, SEQUELIZE_OPTIONS} = require('../config.js');

const sequelize = new Sequelize(DATABASE_URL, SEQUELIZE_OPTIONS);

module.exports = {
    sequelize
};
```

From now on, any time you create an Express app that uses Sequelize, you should include this code. This is where we connect to the database, and there should only ever be one connection to the database in your application code. This single instance gets used throughout the app. As we just saw in `./models/poll.js`, we import the Sequelize instance exported by `./db/sequelize.js` and call `.define` on that instance. If we had 10 different models in your app, all 10 would import this same instance.

This is called the [singleton](https://en.wikipedia.org/wiki/Singleton_pattern) design pattern. The job of `./db/sequelize.js` is to create the single connection that the rest of our app (specifically our models) can use to interact with the database.

The key takeaway here is that your Sequelize apps will need to have a module that creates a Sequelize instance, and that instance will be imported by your models. You can follow the same pattern we've used here (i.e., the code from `./db/sequelize.js`) in the apps you create.

Also, be aware that the approach we're recommending here is slightly different than what you may find if you Google "sequelize express example". That search would likely lead you to [this example](http://docs.sequelizejs.com/en/1.7.0/articles/express/) from the docs for an earlier version of Sequelize. While we won't go into the details of why and how here, know that this example uses a quirky design pattern that is hard to reason about and quite different than the experience of working with comparable ORMs.

## Defining models

We've already learned that each model we define in our app needs to import the single Sequelize instance exported by `./db/sequelize.js`. Now let's see what our model definitions look like.

Inside of `./models/poll.js`, we have the following model definition:

```javascript
const Sequelize = require('sequelize');
const {sequelize} = require('../db/sequelize');

const Poll = sequelize.define('poll', {
    name: {
      type: Sequelize.TEXT,
      // this stops this column from being blank
      allowNull: false
    },
    question: {
      type: Sequelize.TEXT,
      allowNull: false
    },
    yesVotes: {
      type: Sequelize.INTEGER,
      defaultValue: 0,
      field: 'yes_votes'
    },
    noVotes: {
      type: Sequelize.INTEGER,
      defaultValue: 0,
      field: 'no_votes'
    }
  }, {
    tableName: 'polls',
    underscored: true,

    classMethods: {
      // relations between models are declared in `.classMethods.associate`.
      associate: function(models) {
        // no associations for this model so nothing here
      }
    }
  }
);

```

At the top of this module, we first import the Sequelize library. We'll use this in our model definitions to get access to Sequelize's data types (for instance, `Sequelize.INTEGER`).

We also import our single Sequelize instance (which is connected to the database). To define a new model, we use [`sequelize.define`](http://docs.sequelizejs.com/en/latest/api/sequelize/#definemodelname-attributes-options-model), which takes three arguments: a string name of the model, an object representing the attributes (which in database-land means columns) of the model, and an optional third object that can be used to configure class and instance methods and how the model maps to the database.

Here, we supply `'poll'` as the name of our model.

The second argument contains our attribute definitions. We define a `name` attribute. `name` must be a string, and we make it non-nullable by including the `allowNull: false` option. Note that if this was an optional field, we could use the following shorthand:

```javascript
const Poll = sequelize.define('poll', {
    name: Sequelize.TEXT
    // ...
});
```

Like `name`,  `question`'s data type is also text, and it cannot be null.

`yesVotes` and `noVotes` are a bit different. The data type for both of these is integer. We use `defaultValue: 0` so if a new poll is created and we don't explicitly provide a value for these attributes, they'll automatically get assigned a value of 0.

Next we get to another of Sequelize's quirks. We're defining `yesVotes` and `noVotes` attributes on our model. However, the `field: 'yes_votes'` / `field: 'no_votes'` says that when we refer to `myPollInstance.yesVotes` in our JavaScript code, this maps to the column name `yes_votes` in our `polls` table in the database.

The reason we do this is to preserve JavaScript's casing convention (camel case) for our application code, while avoiding issues with case-sensitivity in Postgres. In real-world apps, you'll sometimes need to directly run queries or migrations in the database layer, using SQL.

While it's possible to have camel case column names in your database, it requires you to use quotation marks in your SQL queries. We _could_ use camel case in both the application and database layer. So in our model definition, we'd have:

```javascript
const Poll = sequelize.define('poll', {
   // ...
    yesVotes: {
      type: Sequelize.INTEGER,
      defaultValue: 0
    },
    // ...
});
```

And in our SQL script for defining the database, we'd have:

```sql
CREATE TABLE polls (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    question TEXT NOT NULL,
    "yesVotes" INTEGER,
    "noVotes" INTEGER
);

```

Normally, we don't use quotation marks around table or column names in our SQL code, but column and table names in Postgres are case-insensitive unless you put them in quotation marks. So a query involving `yesVotes` would look like:

```sql
SELECT "yesVotes" FROM polls WHERE...
```

In contrast, when the column name is "yes_votes", we can just do:

```sql
SELECT yes_votes FROM polls WHERE...
```

Ultimately, we must choose one of three imperfect options: 1. using snake case in both our database and our application layer (in which case we break JavaScript's casing convention), 2. using camel case in both (in which case, we have to remember to use quotation marks when we're writing SQL queries), or 3. mapping a camel-cased attribute to a snake-cased column name by using the `field` property in our attribute definition. We recommend using the third approach.

The third argument to our model definition is an optional configuration object:

```javascript
{
    tableName: 'polls',
    underscored: true,

    classMethods: {
      // relations between models are declared in `.classMethods.associate`.
      associate: function(models) {
        // no associations for this model so nothing here
      }
    }
  }
```

The `tableName` property here plays a similar role to the `as` property in our column definitions. It says that our model (which we called 'poll' with the first argument to our model definition) corresponds to the `'polls'` table in our database. If you don't specify a `tableName`, Sequelize automatically takes the model name and pluralizes it. Here that wouldn't create any issues, but we think it's best to be explicit about which table the model corresponds to, rather than having Sequelize do this behind the scenes.

`underscored: true` has to do with the column names for fields that Sequelize automatically creates. Recall that our API returns `created_at` and `updated_at` properties. Sequelize automatically puts a `createdAt` and `updatedAt` attribute on each model you create. The `underscored: true` option tells Sequelize that these column names are `created_at` and `updated_at` in our database.

Last, we define a `classMethods` option. Currently, it has an `associate` method that doesn't do anything. However, in the next assignment, we'll see how we use this to define relationships between models.

Finally, a note on model imports and exports. `./models/poll.js` exports our poll model. However, with the exception of `./models/index.js`, no other modules in our app should import the poll model from its original module. As we'll see, our application should always import models from `./models/index.js`.

```javascript
'use strict';


// Any time you create a new model for an app, import it here
const {Poll} = require('./poll');

// All models you want to expose to other modules should go here
const db = {
    Poll
};

Object.keys(db).forEach(function(modelName) {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

module.exports = db;

```

The reasoning for this will become clearer in the next assignment when we walk through a more complex app that has multiple models that refer to one another. For now, it's enough to know that you should have a `./models/index.js` file that looks like this one in all your Sequelize apps.

All of your apps models should be imported to `./models/index.js`, and added to the `db` constant. The `Object.keys(db)...` part iterates over each model in `db` and checks to see if the model has an `associate` class method, calling it if it exists. Ultimately, this module exports all of our models, but only after having associated each one.

## Using models in routes

The final topic to cover in this assignment is how we use Sequelize models in our routes. Like Mongoose, Sequelize provides  standard class methods like `create`, `findOne`/`findAll`, `update`, and `destroy` that we use for CRUD operations.

In this app, all of our routes are found in `./app.js`. We're not going to walk through each line of this code, because most of it should look familiar. For instance, the code for validating required properties for `POST` requests is the same as in earlier apps, and doesn't change now that we're using Sequelize.

Here's our route for retrieving all posts in the database:

```javascript
app.get('/polls', (req, res) => Poll.findAll()
    .then(polls => {
    return res.json({polls: polls})
  })
);
```

Like with Mongoose, Sequelize queries return a promise object. Here, we use the `findAll` method. Behind the scenes, Sequelize converts this into a SQL query.

Spend a few minutes looking over our routes, paying attention to the use of `findAll`, `findById`, `create`, `update`, and `destroy`. You can read up on these methods in the [Sequelize docs](http://sequelize.readthedocs.io/en/v3/api/model/).

This reading has given you a sense of the basics of working with Sequelize. In the next assignment, we'll examine a more complex app and get into relationships, migrations, and testing.

