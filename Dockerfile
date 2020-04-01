FROM node:current-alpine as builder
WORKDIR /app
COPY . .
RUN yarn install; \
 yarn run build

FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
