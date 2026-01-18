# -------------------------
# Stage 1: Dependencies
# -------------------------
FROM node:14 AS deps

ARG SRC_DIR=/opt/i27
WORKDIR $SRC_DIR

# Copy only package files for better cache
COPY package*.json ./

# Install ALL dependencies (includes devDependencies like cross-env)
RUN npm install


# -------------------------
# Stage 2: Dev Runtime
# -------------------------
FROM node:14 AS dev

ARG SRC_DIR=/opt/i27
WORKDIR $SRC_DIR

# Copy node_modules from deps stage
COPY --from=deps $SRC_DIR/node_modules ./node_modules

# Copy application source
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod
