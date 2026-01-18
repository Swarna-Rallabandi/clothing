# -------------------------
# 1) Build stage
# -------------------------
FROM node:14 AS build

ARG SRC_DIR=/opt/i27
WORKDIR $SRC_DIR

# Copy only package files first (better caching)
COPY package*.json ./

# Install dependencies (use ci if package-lock exists)
RUN npm ci --only=production || npm install --production

# Copy app source
COPY . .

# If your app has a build step (React/Next/Vite etc), keep this:
# RUN npm run build


# -------------------------
# 2) Runtime stage (smaller)
# -------------------------
FROM node:14-slim AS runtime

ARG SRC_DIR=/opt/i27
WORKDIR $SRC_DIR

# Copy only what is needed from build stage
COPY --from=build $SRC_DIR ./

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000
CMD ["/entrypoint.sh"]
