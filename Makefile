install:
	bundle install

test:
	clear
	bundle exec rspec spec

run:
	bundle exec rails server -b 0.0.0.0

docker-build:
	docker build -t rails-app:$(ver) .
