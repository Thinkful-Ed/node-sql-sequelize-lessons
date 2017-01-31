---
type: lesson intro
name: Introducing SQL and PostGres
author: Benjamin White

---

In this lesson, you'll learn about using PostgreSQL, which is a popular, open-source relational database that uses *SQL*.

That's a bunch of terms. Let's define them:

* *PostgreSQL* (Postgres for short), is one of several modern relational databases. Along with MySQL, Postgres is standard choice for an open source relational database. Oracle and Microsoft are the two of the heavyweight proprietary database providers.
* *SQL* stands for *structured query language*. *SQL* is a domain specific language for interacting with *relational databases*. It allows us to create, retrieve, update, and delete database records. While each database will layer on its own additional commands, the syntax for the most common operations are the same. Learning SQL basics for one relational database will make it trivial to pick up your next one.
* A *relational* database stores data in *tables* made up of *columns* and *rows*. If you've ever used a spreadsheet, you already understand the mental model. A table is like a collection in Mongo. It contains instances of the same kind of thing. Each table is made up of columns for different properties of the instances, and rows, which contain the data for a single instance. In contrast to Mongo, which won't stop you from creating documents with completely different schemas in the same collection, in relational database, all rows must have the same columns.

One of the attractive things about MongoDB is that it allows you to write apps where the front end, back end, and database shell are all in a single language. There are also particularly good use cases for schemaless data.

But outside of the MEAN (Mongo Express Angular Node) / MERN (Mongo Express React Node) stack world, SQL-based relational databases are still the norm, and will continue to be for the forseeable future. To be a productive full stack developer, you'll need to be comfortable working with relational databases like Postgres from the shell, and in your Node apps.

In this lesson, we'll learn how to setup a Postgres database server in a local development environment and on [ElephantSQL](https://www.elephantsql.com/), a cloud-based Postgres provider that we'll use.

By the end of this lesson, you'll be comfortable setting up a Postgres server and you'll know how to do basic CRUD (create, read, update, delete) operations using the Postgres shell.

