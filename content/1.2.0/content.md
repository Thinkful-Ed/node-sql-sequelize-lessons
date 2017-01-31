---
type: lesson intro
name: Data modeling and persistence with Sequelize
author: Benjamin White

---

In this lesson, we will learn how to create SQL-backed Express apps using [Sequelize](http://docs.sequelizejs.com/en/v3/).

In some ways, working with Sequelize will feel a lot like working with Mongoose. We'll define models and use built-in methods like `.create`, `.findAll`, and `.update` to alter our database tables from our app. Like Mongoose, most Sequelize methods return promises. Our integration testing strategy will be nearly identical.

Unlike with Mongoose, working with Sequelize, we'll write SQL scripts to set up our database and migrate any changes we make to our data model.

First, we'll look at a minimal Sequelize app to get up to speed on the basics.

After that we'll revisit our NYC restaurant grades app from earlier in the course, re-implementing it using Sequelize instead of Mongoose. We'll walk through setting up CRUD endpoints for `/restaurants`, and then you'll add endpoints for `/grades` on your own.

Next, we'll learn how continuous integration and deployment work with Sequelize.

In the final assignment in this lesson, you'll write a simple blogging app, this time using Sequelize instead of Mongoose.
