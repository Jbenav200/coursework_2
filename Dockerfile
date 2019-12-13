# inherit from the Go official Image
FROM node:11.8

# set a workdir inside docker
WORKDIR /usr/src/app

# copy . (all in the current directory) to . (WORKDIR)
COPY . .

# run a command - this will run when building the image
# RUN npm install

# the port we wish to expose
EXPOSE 8000

# run a command when running the container
CMD node server.js
