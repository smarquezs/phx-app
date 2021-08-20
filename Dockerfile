
FROM elixir:1.11.2
LABEL maintainer="Sergio Márquez <smarquezs@gmail.com>"

# Create and set home directory
ENV HOME /opt/app
WORKDIR $HOME

RUN  apt-get update \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install -y apt-utils \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && apt-get install -y inotify-tools \
    && apt-get install -y postgresql-client

# Install Hex + Rebar
RUN mix local.hex --force
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all dependencies
RUN mix deps.get

COPY . .

EXPOSE 4000
