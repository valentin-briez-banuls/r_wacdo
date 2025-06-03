# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.8
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Installer les packages de base + runtime PostgreSQL
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libjemalloc2 libvips sqlite3 libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test \
    NODE_ENV=production

FROM base AS build

# Installer packages de build
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git libyaml-dev pkg-config libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Installer Node.js (utile même avec importmap)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Nettoyage
RUN rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git || true

# Précompilation Bootsnap (optimisation)
RUN mkdir -p tmp/cache
RUN bundle exec bootsnap precompile --gemfile || echo "⚠️ bootsnap precompile failed"

# Copier tout le code source
COPY . .

# Re-précompile l'app/lib
RUN bundle exec bootsnap precompile app/ lib/ || echo "⚠️ bootsnap precompile app/lib failed"

# Précompilation des assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Préparation de l’utilisateur non-root
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
