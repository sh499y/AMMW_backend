FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/.medusa ./.medusa
COPY medusa-config.ts ./
COPY src ./src
COPY tsconfig.json ./

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]