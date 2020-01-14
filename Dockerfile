FROM node:12.14.0-alpine3.10 AS builder
USER root
WORKDIR /app/web

COPY ./ ./
RUN yarn install --prod \
  && yarn build

FROM nginx:1.17.6-alpine

COPY --from=builder /app/web/build /var/web/dist
COPY --from=builder /app/web/nginx.conf /etc/nginx/conf.d/default.conf
