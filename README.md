# README

* Ruby version

```
3.3.7
```

* System dependencies

```
Docker with docker engine
```

* Configuration/Setup

```
docker compose build
docker compose run web rake db:create:all
docker compose run web rake db:migrate
docker compose run web rake db:test:prepare
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
