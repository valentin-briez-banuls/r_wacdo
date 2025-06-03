# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.2.8
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Installer les packages de base + libpq5 pour runtime PostgreSQL
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

FROM base AS build

# Installer packages nécessaires à la compilation des gems (libpq-dev pour pg)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential git libyaml-dev pkg-config libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./

RUN bundle install

# Debug : lister fichiers importants
RUN ls -la /usr/local/bundle && ls -la tmp || true

RUN rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git || true

RUN mkdir -p tmp/cache

RUN bundle exec bootsnap precompile --gemfile || echo "⚠️ bootsnap precompile failed"

COPY . .

RUN bundle exec bootsnap precompile app/ lib/ || echo "⚠️ bootsnap precompile app/lib failed"

RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000

# Lancement explicite du serveur Rails sur le bon port et interface pour Render
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
