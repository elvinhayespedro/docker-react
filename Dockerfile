##### build phase
FROM node:16-alpine as builder

# WORKDIR
RUN mkdir -p /usr/app/frontend
WORKDIR /usr/app/frontend

# install dependencies in node_modules
COPY ./package.json ./
RUN npm install

# copy source code
COPY ./ ./

# RUN build
RUN npm run build

##### run phase
FROM nginx

# in most env, expose does nothing on localhost
# AWS EBS is going to look for EXPOSE instruction
# AWS EBS will map automatically for incoming traffic
EXPOSE 80

# copy from builder phase
# first param is what to copy
# second param is the destination
COPY --from=builder /usr/app/frontend/build /usr/share/nginx/html
# /usr/share/nginx/html <<< go to nginx on dockerhub
# and see >>> hosting some simple content
