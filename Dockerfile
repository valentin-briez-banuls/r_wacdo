# Étape 1 : Build
FROM ruby:3.2 AS builder

# Variables d'environnement
ARG RAILS_ENV=production
ARG RAILS_MASTER_KEY

ENV RAILS_ENV=$RAILS_ENV \
    RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
    NODE_ENV=production

# Dépendances système
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    curl

# App setup
WORKDIR /app
COPY . .

# Installation des gems
RUN gem install bundler
RUN bundle install --without development test

# Précompilation des assets
RUN bundle exec rails assets:precompile

# Étape 2 : Image finale plus légère
FROM ruby:3.2 AS app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV \
    NODE_ENV=production

# Dépendances système
RUN apt-get update -qq && apt-get install -y \
    libpq-dev \
    nodejs \
    yarn \
    curl

# Dossier app
WORKDIR /app
COPY --from=builder /app /app

# Installation des gems en cache (optionnel)
RUN gem install bundler

# Port d'écoute (si utile)
EXPOSE 3000

# Commande de lancement
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
