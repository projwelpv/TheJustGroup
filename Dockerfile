# Stage 1
FROM node:16.14 as react-build
WORKDIR /app
#COPY . ./
COPY package*.json ./
COPY vite.config.js ./
RUN npm install
COPY . ./
#RUN npm audit fix --force
RUN npm run build


# Stage 2 - the production environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
