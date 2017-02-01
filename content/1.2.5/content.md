---
type: project
name: 'Challenge: blogging app with Sequelize and Postgres'
author: Ben White
time: 300

---

Now it's time to practice writing an Express/Sequelize app from scratch. To complete this challenge, you'll need to create an API for a blogging platform with similar functionality to the one you built with Mongoose earlier in this unit.

## Requirements

Use Express and Sequelize to create an API for a blogging app.

Create models for the following entities:

* Authors
    - An author has an id, first name, last name, and user name. Only the user name is required. These properties should be returned when a user requests this resource from the API.
    - Authors can have many comments and many posts.
    - Authors cannot be deleted via the API.
    - Authors cannot be deleted (via ORM or SQL) if there are any posts that refer to them.
    - If an author is deleted, their comments should also be deleted.
* Comments
    - A comment has an id, comment text, an author id, and is created at properties. These properties should be returned when a user requests this resource from the API.
    - It belongs to an author, and to a post (in other words, authors can make comments on posts).
    - Comments are deleted when their author is deleted.
    - Comments are deleted when their post is deleted.
* Posts
    - A post has id, title, content, created at, and author id properties. These properties should be returned when a user requests this resource from the API.
    - A post belongs to an author and can have zero or more comments.

Create the following endpoints:

* `GET /authors/:id`, which returns info about a single author.
* `POST /authors`, which is used to create a new author.
* `PUT /authors/:id`, which is used to update an author's first name, last name, and/or user name.
* `GET /authors/:id/comments`, which returns all comments from an author.
* `GET /authors/:id/posts`, which returns all posts by an author.
* `POST /comments`, which is used to create a new comment.
* `PUT /comments/:id`, which is used to update the text of a comment.
* `DELETE /comments/:id`, which is used to delete a comment.
* `GET /posts`, which is used to retrieve all posts.
* `POST /posts`, which is used to create a new post.
* `PUT /posts/:id`, which is used to update the title and/or content of a post.
* `DELETE /posts/:id`, which is used to delete a post.
* `GET /posts/:id/comments`, which is used to retrieve all comments from a post.

Additional requirements:

* Write a **SQL migration** script that creates tables for authors, posts, and comments.
* Write a **SQL script** that can be used to initially populate the database with authors, posts, and comments.
* Write at least one **integration test** for each API endpoint. At a minimum, you should write tests for the *normal* case for each endpoint.
* As always, use **Git/Github** to save and back up your work as you go.
* Once your app is working, configure TravisCI to **deploy** it to Heroku. Note that you'll have to set up a database on ElephantSQL. After your tests have passed, seed this database by running the SQL script from the earlier requirement.

Limit yourself to a total of five hours for this challenge. Even if you're not done at that point, submit a link to your GitHub repo below.

When you've finished, you can look at the source code for [this example solution](https://github.com/Thinkful-Ed/node-blog-app-with-sequelize).

