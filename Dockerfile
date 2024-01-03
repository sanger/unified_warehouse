FROM ruby:2.7

RUN gem install bundler -v 2.4.22

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["/code/bin/run.sh"]