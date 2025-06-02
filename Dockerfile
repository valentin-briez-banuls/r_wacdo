# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.2.8
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Installer les packages de base
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

FROM base AS build

# Installer les packages nécessaires à la compilation des gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copier Gemfile et Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Étape 1 - Installer les gems
RUN bundle install

# Étape 2 - Debug : lister les fichiers importants
RUN ls -la /usr/local/bundle && ls -la tmp || true

# Étape 3 - Nettoyer certains caches (sans bloquer la build si ça échoue)
RUN rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git || true

# Étape 4 - Créer dossier tmp/cache nécessaire à bootsnap
RUN mkdir -p tmp/cache

# Étape 5 - Précompilation bootsnap (désactivable en cas de problème)
RUN bundle exec bootsnap precompile --gemfile || echo "⚠️ bootsnap precompile failed"

# Copier le reste du code de l’application
COPY . .

# Précompilation bootsnap sur dossiers app/ et lib/
RUN bundle exec bootsnap precompile app/ lib/ || echo "⚠️ bootsnap precompile app/lib failed"

# Précompilation des assets pour la production (dummy key pour contourner)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

FROM base

# Copier les gems et l'application depuis l’étape build
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Création d’un utilisateur non-root pour la sécurité
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
