FROM elixir:1.9 as releaser

# WORKDIR /app

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# COPY config/ /app/config/
# COPY mix.exs /app/
# COPY mix.* /app/

# COPY apps/rent_today/mix.exs /app/apps/rent_today/
# COPY apps/rent_today_web/mix.exs /app/apps/rent_today_web/

ENV MIX_ENV=prod
RUN mix do deps.get --only $MIX_ENV, deps.compile

COPY . /app/

WORKDIR /app/apps/rent_today_web
# RUN MIX_ENV=prod mix compile
# RUN npm install --prefix ./assets
# RUN npm run deploy --prefix ./assets
RUN mix phx.digest

WORKDIR /app
RUN MIX_ENV=prod mix release

########################################################################

FROM elixir:1.9

ENV MIX_ENV=prod \
SHELL=/bin/bash

WORKDIR /app
COPY --from=releaser /app/_build/prod/rel/registrar_umbrella .
COPY --from=releaser /app/bin/ ./bin

CMD ["./bin/start"]
