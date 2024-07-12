# Use the official NGINX base image
FROM nginx:alpine

# Create a non-root user named shaik
RUN addgroup -S shaikgroup && adduser -S shaik -G shaikgroup

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the NGINX configuration files
COPY nginx.conf /etc/nginx/nginx.conf
# COPY default.conf /etc/nginx/conf.d/default.conf

# Copy your static files to the appropriate directory
COPY html /usr/share/nginx/html

# Create necessary directories and set permissions
RUN mkdir -p /var/lib/nginx/tmp /var/log/nginx /run/nginx /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/scgi_temp /var/cache/nginx/uwsgi_temp \
    && chown -R shaik:shaikgroup /etc/nginx /var/lib/nginx /var/log/nginx /run/nginx /var/cache/nginx /usr/share/nginx/html \
    && chmod -R 755 /etc/nginx /var/lib/nginx /var/log/nginx /run/nginx /var/cache/nginx /usr/share/nginx/html
# Ensure permissions for the pid file directory
# Ensure permissions for the pid file directory
RUN mkdir -p /var/run/nginx \
    && chown -R shaik:shaikgroup /var/run/nginx
# RUN touch /var/run/nginx/nginx.pid \
#     && chown shaik:shaikgroup /var/run/nginx/nginx.pid
# Switch to the non-root user
USER shaik

# Expose port 8080
EXPOSE 8080

# Run NGINX
CMD ["nginx", "-g", "daemon off;"]
