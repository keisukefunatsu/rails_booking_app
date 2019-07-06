# README

## Setup

- clone app

```
rails db:migrate
rails db:seed
```

## Testing request

```
# get authentication token
curl -H "Content-Type: application/json" -X POST -d '{"email": "admin@example.com","password": "123123123"}' http://localhost:8080/authenticate

# with authorization header
curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVfYXQiOiIyMDE5LTA3LTA3IDA4OjM1OjU0IFVUQyJ9.wIY8pZdgTdhpop8a6BCBspjONLoU3172fJ7TA8nZnkQ" http://localhost:8080/users
```