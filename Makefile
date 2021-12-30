install:
	bundle install

lint:
	bundle exec rubocop .

test:
	rake test