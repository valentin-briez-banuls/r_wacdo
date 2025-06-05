# Étape 1 : Build
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
    yarn \
    curl

WORKDIR /app
COPY . .

RUN gem install bundler

# Installe les gems dans /bundle
RUN bundle config set path /bundle
RUN bundle install --without development test

RUN bundle exec rails assets:precompile

# Étape 2 : Image finale plus légère
FROM ruby:3.2 AS app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV \
    NODE_ENV=production \
    PATH="/bundle/bin:$PATH"

RUN apt-get update -qq && apt-get install -y \
    libpq-dev \
    nodejs \
    yarn \
    curl

WORKDIR /app

COPY --from=builder /app /app
COPY --from=builder /bundle /bundle

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
