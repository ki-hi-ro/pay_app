# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.1.7
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT=""

FROM base as build

ENV BUNDLE_DEPLOYMENT="false"

RUN gem update --system 3.4.10 && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev

COPY Gemfile Gemfile.lock ./

RUN bundle lock --add-platform x86_64-linux && \
    bundle config set build.nokogiri --use-system-libraries && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile --trace || true

FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libvips \
    postgresql-client \
    libxml2 \
    libxslt1.1 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# 👇 railsユーザー追加
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# 👇 entrypoint.sh を追加
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# 👇 Entrypoint を差し替え
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 3000

CMD ["./bin/rails", "server"]