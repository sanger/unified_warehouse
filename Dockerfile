FROM ruby:3.4.1

RUN gem install bundler

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["/code/bin/run.sh"]