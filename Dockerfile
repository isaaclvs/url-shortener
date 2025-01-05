FROM ruby:3.3.0

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update -qq \
    && apt-get install -y nodejs default-mysql-client netcat-traditional \
    && npm install -g npm@latest

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENV FOREMAN_WORKER_TERM_TIMEOUT=30
ENV TERM=xterm

EXPOSE 9292

ENTRYPOINT ["entrypoint.sh"]
CMD ["./bin/dev"]