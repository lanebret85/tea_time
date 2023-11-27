# Tea Time

## Summary
This application is a backend application that exposes 3 endpoints for Tea Subscriptions that Customers can purchase. All information about customers, subscriptions, and teas that come with each subscription is stored in a local PostgreSQL database and requires the application consuming the endpoints to pass in data as request parameters about the customer(s) or the subscription(s) they're trying to create/access.

## Setup Instructions
To set up this application locally, (optionally fork, and then) clone down to your local machine. In your terminal, run `bundle install` and then `rails db:{create,migrate,seed}`. If you want to consume the endpoints using Postman, run `rails s` in the terminal to start the server, and then input `https://localhost:3000` as the base url in Postman preceded by the HTTP verb listed below and followed by the URI listed below for the desired endpoint.

## Endpoints
1. Subscriptions Index - Lists all subscriptions for a customer - requires a Customer ID passed in the request parameters - HTTP verb: **GET** - URI: **"/api/v1/customers/subscriptions"**
2. Subscriptions Create - Creates a new subscription for a customer (essentially, subscribes a customer to a subscription) - requires a Customer ID and a Subscription Title, Price, Status, and Frequency passed in the request parameters - HTTP verb: **POST** - URI: **"/api/v1/customers/subscriptions"**
3. Subscriptions Update - Updates a subscription for a Customer to change the status (intention is to allow a subscription to be updated from active to canceled) - requires a Subscription ID passed in the request parameters - HTTP verb: **PATCH** - URI: **"/api/v1/customers/subscriptions"**

## Testing Instructions
After you've run `bundle install` and `rails db:{create,migrate,seed}`, you can run `bundle exec rspec` in your terminal to run the full test suite. If you want to run a single test file or even a single test block from a test file, you can run `bundle exec rspec spec/api/v1/customers/subscriptions/{test file you want to run}` or `bundle exec rspec spec/api/v1/customers/subscriptions/{test file you want to run}:{line number of the test block you want to run}` respectively.
