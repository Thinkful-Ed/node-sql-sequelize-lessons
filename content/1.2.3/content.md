---
type: project
name: 'Challenge: complete the restaurant grades app'
author: Ben White
time: 180

---

In the previous two assignments, you learned how to integrate Sequelize into an Express app. In this challenge, you'll practice working with Sequelize's models by adding CRUD endpoints for the grades model.


## Requirements

The starting point for this assignment is the master branch of [this repo](https://github.com/Thinkful-Ed/node-restaurants-sequelize-tests), which we explored in the previous assignment.

After cloning the repo, you'll need to create a new repo on GitHub and then point your local repo to the new remote. Now, inside your local repo, you'll need to run `git remote set-url origin git@github.com:account-name/repo-name.git`.

To complete this challenge, add the following routes for grades:

* `GET /grades/:id` This route is for retrieving a single grade.
* `POST /grades` This route is for creating a new grade. Note that because grades must refer to a restaurant, POST requests will need to include a restaurant id that the grade is for.
* `PUT /grades/:id` This route is for updating grades. Clients should be able to update the `score`, `grade`, `inspectionDate`, and `restaurantId` attributes on a grade.
* `DELETE /grades/:id` This route is for deleting a specific grade.

Additionally, you'll need to write integration tests for each endpoint. At a minimum, you should write a test for the normal case for each endpoint.

Spend up to three hours to complete this assignment. Then, whether you're finished or not, push your work up to GitHub and submit a link to the repo below to share with your mentor. Now, look at [this example solution](https://github.com/Thinkful-Ed/node-restaurants-sequelize-tests/tree/feature/solution).

