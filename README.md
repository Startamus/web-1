# README

* Ruby version

```
3.3.7
```

* System dependencies

```
- Docker with docker engine
```

* Configuration

```
docker compose build
docker compose up db
bundle exec rake db:create:all
bundle exec rake db:migrate
bundle exec rake db:test:prepare
```

* Run tests

```
docker compose run --remove-orphans test
```

* Run application

```
docker compose up
```

[http://localhost:3000](http://localhost:3000)
