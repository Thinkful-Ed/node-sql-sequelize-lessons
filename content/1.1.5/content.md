---
type: written content
name: Postgres in the cloud
author: Ben White
time: 30

---

In this assignment, we'll learn how to set up a database in [ElephantSQL](https://www.elephantsql.com/). Later in this unit, when we start deploying Postgres-backed apps, we'll use ElephantSQL to host our database.

First, you'll need to create an account or else sign in with Gmail or GitHub at ElephantSQL. You can do that [here](https://customer.elephantsql.com/login).

Next, from the dashboard, you'll need to create a new database instance. Let's call our database `scratch-db` since we'll just use it to learn Elephant SQL.

Choose the free option for plan, and go with the default value for data center, then click "Create new instance".

Once the new instance is created, you can click on it to get the details about the database server. Of particular note are the values for server, username/database name, password, and the URL. We'll use the URL value when we want to connect to this database from the command line, and also in our Express apps.

![create-elephant-sql-instance.gif](create-elephant-sql-instance.gif)

Let's upload our backup restaurants data to Elephant SQL and then log in to the shell. From the command line, run the following command:

```
psql postgres://username:password@host.com:5432/dbName -f ./backup.sql
```

Substitute in the URL for your database, and the path to the backup data for the `-f` flag. You should see the same output you got when you restored this data to your local db.

To log in to a Postgres shell on our ElephantSQL database, we use the same `psql` command we use locally, but we supply the URL instead of the database name:

```sql
psql postgres://lxpqqsnc:POOWGwPWzuV-QhYcjm0P88bURb2Jxo1i@elmer.db.elephantsql.com:5432/lxpqqsnc
```

From there, it's just the same as working with Postgres locally.

To quit, run `\q`.
