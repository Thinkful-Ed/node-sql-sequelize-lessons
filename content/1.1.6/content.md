---
type: project
name: "Challenge: blog app database"
author: Ben White
time: 90

---

To close out this lesson, your challenge is to create a Postgres database for a blogging platform. You'll write a SQL script that you can use to create and seed a database on Elephant SQL.

## Requirements

Create a single SQL (`.sql`) file that creates tables and inserts some records into a blog database. When you're done, create a database on ElephantSQL called `blog-app-challenge`. Then, run your script from the command line, pointing to the database URL for ElephantSQL. Share the db with your mentor.

Here are the details:

* Keep it to 90 minutes. Whether or not you're done, check out the example solution and save and submit your work.
* The database should support the following:
    - *Users* can write *posts* and *comments*.
    - *Users* have first names, last names, email addresses, and screen names. Email addresses and screen names are required.
    - Each *post* has a single author (who is a *user*), a title, content, a published timestamp, zero or more *comments*, and zero or more *tags*.
    - A *comment* has one author (aka user), one post (the original post the comment is about), and the comment text itself.
    - A *tag* has tag text. For instance "current events".
    - As a stretch goal, configure *comments* so they can have a referring comment. In other words, each comment can optionally point to another comment.
* In the same script, write SQL statements to create some users, posts, and comments.
* Ultimately, you need a script that can be run like this: `psql <database> -f ./bootstrap-blog-app.sql`. When you've got this script, save it to Gist or Github.
* Create a new ElephantSQL instance and run your SQL script.

## Example solution

Here's [one way](https://gist.github.com/benjaminEwhite/08e492778159fb71402f4f23242dce9c) you could model this problem.
