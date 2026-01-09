FROM node:22

WORKDIR /app

# Install backend deps
COPY backend/package*.json ./backend/
RUN cd backend && npm install

# Install frontend deps
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

# Copy source
COPY backend ./backend
COPY frontend ./frontend

EXPOSE 5000 5173

RUN npm install -g concurrently

CMD ["concurrently", \
"npm start --prefix backend", \
"npm run dev --prefix frontend -- --host"]
