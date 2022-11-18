FROM node:lts-alpine AS builder

RUN mkdir /app

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./

COPY src src

RUN npm install
RUN npm run build

FROM node:lts-alpine

RUN mkdir /app
WORKDIR /app

COPY . /app/
COPY --from=builder /app/dist dist

RUN npm install

CMD ["npm", "start"]
