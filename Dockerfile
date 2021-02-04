FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y
RUN apt-get -y install git vim

RUN gem install bundler

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["/code/bin/run.sh"]