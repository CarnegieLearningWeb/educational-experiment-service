FROM node:12.7.0-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY . .

# Moved these build steps to github actions, so that all necessary files are included in the zip artifact that gets built
# All elastic beanstalk has to do when it deploys that zip file is copy the files and start the app
#RUN cd packages/Upgrade && yarn
#RUN ["npm", "run", "build:upgrade"]


EXPOSE 3030
CMD ["npm", "run", "production:upgrade"]
