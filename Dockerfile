# Use the lightweight Nginx Alpine image as the base
FROM nginx:alpine

# Copy the pre-built static files from your local 'dist' folder to the Nginx web root
COPY ./dist /usr/share/nginx/html

# Update the Nginx configuration to listen on port 3000 as requested
RUN sed -i 's/listen       80;/listen       3000;/' /etc/nginx/conf.d/default.conf

# Inform Docker that the container listens on port 3000 at runtime
EXPOSE 3000

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
