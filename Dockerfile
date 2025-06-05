# Étape 1 : Build des assets
FROM ruby:3.2 as builder

# Installation des dépendances système
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Créer le dossier de l'app
WORKDIR /app

# Copier les fichiers
COPY . .

# Installer les gems
RUN bundle install

# Passer la master key au moment du build
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

# Précompilation des assets (avec clé de chiffrement pour credentials.yml.enc si nécessaire)
RUN bundle exec rails assets:precompile

# Étape 2 : Image finale plus légère
FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y libpq-dev nodejs

WORKDIR /app

COPY --from=builder /app /app

# Re-bundle si besoin (optionnel si on copie `vendor/bundle`)
RUN bundle install

EXPOSE 3000

# Lancer le serveur
CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails s -b 0.0.0.0"]
