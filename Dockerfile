FROM sovrynbase:latest as build

ARG DEBIAN_FRONTEND="noninteractive"
ARG NODE_VERSION=14

WORKDIR /var/www/


FROM build as dev

COPY webpack* packa* yarn.lock /var/www/

RUN mkdir -p \
		/var/www/public/dist \
		/var/www/logs \
		/var/www/db \
		/var/www/secrets

RUN yarn install --immutable
# Stuff for yarn
RUN npm run build-client
# Add our code
COPY . /var/www


FROM sovrynbase:latest as release

# This should copy our code and everything installed by yarn.

COPY --from=dev /var/www/ ./

RUN yarn global add mocha nodemon




