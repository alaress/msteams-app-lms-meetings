FROM node:current as builder
WORKDIR /app
COPY . .
RUN yarn install; \
 yarn run build

FROM node:current-alpine
RUN yarn global add serve
WORKDIR /app
COPY --from=builder /app/build .
CMD ["serve", "-p", "5000", "-s", "."]
EXPOSE 5000
