# Readers' Haven — multi-stage Dockerfile.
# Stage 1 builds the static site with Node.js + Parcel.
# Stage 2 serves only the built files from a small Nginx image.
# Pinned tags only (no :latest); COPY is used instead of ADD.

# ---------- Stage 1: builder ----------
# Node.js image: provides npm and Parcel to build the site.
FROM node:22-alpine AS builder
# All build work happens in /app.
WORKDIR /app
# Copy the package files first, so this layer stays cached when only pages change.
COPY package*.json ./
# Install the exact versions from package-lock.json (clean install).
RUN npm ci
# Copy the website sources into the build image.
COPY src/ ./src/
COPY styles/ ./styles/
# Build all pages in src/ into dist/.
RUN npm run build

# ---------- Stage 2: runtime ----------
# Small Nginx image: serves static files only (no Node.js, no node_modules).
FROM nginx:1.27-alpine
# Copy ONLY the built site from the builder stage into Nginx's web folder.
COPY --from=builder /app/dist /usr/share/nginx/html
# The site listens on port 80 inside the container.
EXPOSE 80
# Run Nginx in the foreground so the container keeps running.
CMD ["nginx", "-g", "daemon off;"]
