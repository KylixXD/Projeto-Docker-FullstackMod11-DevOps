# Primeira etapa - Build 

FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install 

COPY . .

# Segunda etapa - Imagem Final 
FROM node:20-alpine 

WORKDIR /app 

COPY --from=builder /app .

RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && mkdir -p /etc/todos \
    && chown -R appuser:appgroup /etc/todos

USER appuser

EXPOSE 3000 

CMD [ "node", "src/index.js" ]

