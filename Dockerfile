FROM elixir:latest

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN sh -c 'curl --silent --location https://deb.nodesource.com/setup_6.x | bash -'

RUN apt-get update -qq && apt-get install -y build-essential postgresql-9.5 postgresql-client-9.5 libpq-dev curl \
            nodejs build-essential libpq-dev curl postgresql-client \
            locales

RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen ru_RU.UTF-8
RUN dpkg-reconfigure -fnoninteractive locales
ENV LC_ALL=ru_RU.utf8
ENV LANGUAGE=ru_RU.utf8
RUN update-locale LC_ALL="ru_RU.utf8" LANG="ru_RU.utf8" LANGUAGE="ru_RU"

RUN npm i -g yarn

ENV APP_PATH /myapp
ENV PATH $APP_PATH/nodemodules/.bin:$PATH

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

WORKDIR /myapp

EXPOSE 4000
