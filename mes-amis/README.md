# devops-terraform-exercise

A small Sinatra app with two routes:

- `GET /ping` — AWS health check, responds with `pong`
- `GET /current_time` — responds with the current time queried from the
  database configured via the `DATABASE_URL` environment variable

## Development

Requires Docker.

### Starting the app

Start the app and Postgres:

```sh
docker compose up --build
```

Then:

```sh
curl http://localhost:4567/ping
# => pong

curl http://localhost:4567/current_time
# => 2026-06-05 23:59:59.000000+00
```

### Running the tests

The minitest suite stubs the database, so it runs without Postgres:

```sh
docker compose run --rm --no-deps app bundle exec rake
```
