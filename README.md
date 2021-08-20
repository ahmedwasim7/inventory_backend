
# Inventory System


## Technology stack

- Ruby 3.0.1
- Ruby on Rails 6.1.4
- MySQL 8.0.26
- Application Server: Puma

## Installation

### Requirements

Before you get started, the following needs to be installed:
  * **Ruby**. Version 3.0.1 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [RVM](https://rvm.io//) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
  * **Redis**.
  * [**RubyGems**](http://rubygems.org/)
  * **Bundler**: `gem install bundler`
  * [**Git**](http://help.github.com/git-installation-redirect)
  * **A database**. Only MySQL 8 has been tested, so we give no guarantees that other databases (e.g. PostgeSQL) work. You can install MySQL my following these [**instructions**](https://gist.github.com/learncfinaweek/4120988)


## Install


1.  Install the required gems by running the following command in the project root directory:

    ```bash
    bundle install
    ```

2.  Create and populate database with seeds using:
    ```
    rails db:create db:migrate db:seed
    ```

3.  Run server:

    ```
    rails server or rails s
    ```

## Notes
- Implemented a basic level of JWT authentication.
- Added Pagination for inventories.
- Added Serializers for data beautification.
- Added RSpec Test Cases.

## Future Work
- We can add proper Authentication Process using Devise gem.
- We can add overcommit to make sure code quality or other stuff.
- We can add Rubocop for better code quality.

