FROM node:22.22.0-alpine3.23

WORKDIR /frontend

EXPOSE 5173

# CMD ["npm", "run", "dev"]
CMD ["sh", "-c", "npm install && npm run dev"]