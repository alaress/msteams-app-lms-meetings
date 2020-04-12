FROM node:current-alpine as builder
WORKDIR /app
COPY . .

ARG CLIENT_ID
RUN sed -i -e 's/CLIENT_ID/'"$CLIENT_ID"'/' "src/auth/msalApp.ts"

RUN yarn install; \
    yarn run build

FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
