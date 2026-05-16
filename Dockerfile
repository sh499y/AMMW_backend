FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

ARG MEDUSA_BACKEND_URL
ENV MEDUSA_BACKEND_URL=${MEDUSA_BACKEND_URL}

RUN npm run build && echo "=== Admin build check ===" && ls -la .medusa/server/public/admin/

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]