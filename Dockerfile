FROM ruby:alpine as production

RUN mkdir -p /code
WORKDIR /code

COPY Gemfile /code
COPY Gemfile.lock /code

RUN bundle install --without test

COPY src /code/src

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "src/main.rb"]

FROM production as test

RUN bundle install --with test
COPY spec /code/spec

CMD ["bundle", "exec", "rspec", "--format", "documentation"]
