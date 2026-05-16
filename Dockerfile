FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build && ls -la .medusa/server/public/admin/

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]