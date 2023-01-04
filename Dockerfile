FROM node:14-slim

WORKDIR /usr/src/app

# Copy only package.json and package.lock.json into workdir first - use docker's caching and avoid npm install for each code change
COPY ./package*.json ./

RUN npm install

# Now copy the rest of our code
COPY . .

# Use non-root node user instead of default root user
USER node

EXPOSE 3000

CMD ["npm", "start"]
