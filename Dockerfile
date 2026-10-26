FROM ruby:3.4.12-slim

RUN apt-get update \
    && apt-get install --yes --no-install-recommends build-essential git imagemagick libyaml-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]
