# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of understanding Rails. 

Admins can add products and categories to the store. Users can signup/login, add items to their cart and purchase selected items using Stripe API. App applies the MVC model, and RSpec testing. 

## Getting Started

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars, as well as a Admin Username and Password
8. Run `bin/rails s`

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* bcrypt
* RSpec
* Stripe
