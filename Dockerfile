FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

ENV NODE_ENV=production

RUN npm run build

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]