FROM node:9.11.2-alpine as builder

# Set the app label
LABEL app=ng6-test

# # # # Run the build steps as Root
# USER root

COPY package.json package-lock.json ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

RUN ls -al

COPY . .

RUN ls -al


## Build the angular app in production mode and store the artifacts in dist folder
RUN $(npm bin)/ng build -c $active_env

RUN ls -al

RUN cd dist

# WORKDIR /dist


RUN pwd

RUN ls -al


FROM nginx:1.13.3-alpine

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY ./dist/ng6 /usr/share/nginx/html
RUN chmod 777 /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]

# ## Remove default nginx website
# RUN rm -rf /usr/share/nginx/html/*
# ## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
# COPY dist/ng6 /usr/share/nginx/html
# RUN chmod 777 /usr/share/nginx/html
# CMD ["nginx", "-g", "daemon off;"]



# FROM node:9.11.2-alpine as builder

# EXPOSE 8080

# # # Create the user 1001
# # RUN useradd -u 1001 -r -g 0 -d /home  -s /sbin/nologin  -c "Default Application User" default

# COPY package.json package-lock.json ./

# RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

# ## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
# RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

# WORKDIR /ng-app

# COPY . .

# ## Build the angular app in production mode and store the artifacts in dist folder
# RUN $(npm bin)/ng build --prod

# FROM nginx:1.13.3-alpine

# ## Copy our default nginx config
# COPY nginx/default.conf /etc/nginx/conf.d/

# ## Remove default nginx website
# RUN rm -rf /usr/share/nginx/html/*

# ## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
# COPY --from=builder /ng-app/dist /usr/share/nginx/html

# CMD ["nginx", "-g", "daemon off;"]

# EXPOSE 8080


##################Of Docker
# FROM nginx:1.13.3-alpine
# ## Remove default nginx website
# RUN rm -rf /usr/share/nginx/html/*
# ## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
# COPY /dist /usr/share/nginx/html
# CMD ["nginx", "-g", "daemon off;"]