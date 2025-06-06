FROM ruby:3.2 AS app

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV NODE_ENV=production PATH="/bundle/bin:$PATH"

RUN apt-get update -qq && apt-get install -y libpq-dev nodejs yarn curl

WORKDIR /app

COPY --from=builder /app /app
COPY --from=builder /bundle /bundle

# Debug avant lancement
RUN ls -l /bundle/bin
RUN which puma || echo "puma executable not found"
RUN bundle list

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
