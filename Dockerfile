FROM ruby:3.2 AS builder

ARG RAILS_ENV=production
ARG RAILS_MASTER_KEY

ENV RAILS_ENV=$RAILS_ENV \
    RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
    NODE_ENV=production

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app
COPY . .

RUN gem install bundler
RUN bundle install --without development test

RUN yarn install

RUN bundle exec rails assets:precompile

FROM ruby:3.2 AS app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV \
    NODE_ENV=production

RUN apt-get update -qq && apt-get install -y \
    libpq-dev \
    nodejs \
    curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

COPY --from=builder /app /app

RUN gem install bundler
RUN bundle install --without development test

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
