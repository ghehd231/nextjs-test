# Build environment
FROM node:12.8.0 as builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . .
RUN npm install
RUN npm run build

FROM nginx:1.16.0-alpine
COPY --from=builder /app/.next /usr/share/nginx/html
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 
VOLUME /var/log/nginx 