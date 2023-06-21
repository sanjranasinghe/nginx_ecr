FROM nginx

# Update package lists and install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends python3-pip && \
    pip3 install --no-cache-dir awscli

# Set APT_PROXY environment variable if using a proxy
# ENV APT_PROXY=http://your-proxy-server:port

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
