# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database setup

```
docker compose up db
bundle exec rake db:create:all
bundle exec rake db:migrate
bundle exec rake db:test:prepare
```

* How to run the test suite

```
docker compose run --remove-orphans test
```

