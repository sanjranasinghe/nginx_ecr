FROM nginx

# Update package lists and install dependencies
RUN sed -i 's/archive.ubuntu.com/mirror.example.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends python3-pip && \
    pip3 install --no-cache-dir awscli

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy HTML file
COPY index.html /usr/share/nginx/html

# Expose port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
