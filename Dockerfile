# stage 1 Node

FROM node:alpine AS myprojectfinaktiva
WORKDIR /app
COPY package*.json /app/
COPY . .
ARG configuration=production
RUN npm ci && npm run build -- --output-path=./dist/out --configuration $configuration

# stage 2 Nginx

FROM nginx:alpine
COPY --from=myprojectfinaktiva /app/dist/out /usr/share/nginx/html
COPY ./nginx-custom.config /etc/nginx/conf.d/default.conf
EXPOSE 80
