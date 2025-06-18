FROM ruby:3.3.0-slim-bookworm

RUN apt-get update -qq && apt-get install -y   build-essential   nodejs   npm   yarn   imagemagick   libvips   tzdata   --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN gem install bundler:2.6.5

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs $(nproc) --retry 3 --without development test

COPY . .

RUN RAILS_ENV=production bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-b", "tcp://0.0.0.0:3000"]
