FROM node:16.13.0

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install nodejs -y
RUN mkdir /app
WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./

COPY src src

RUN npm install
RUN npm run build

FROM node:16.13.0

RUN mkdir /app
WORKDIR /app

COPY . /app/
COPY --from=builder /app/dist dist

RUN npm install

CMD ["npm", "start"]
