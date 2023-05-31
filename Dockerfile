FROM nginx
# Install AWS CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir awscli

# Fetch app setting from Systems Manager Parameter Store and set as environment variable
RUN export MY_APP_SETTING=$(aws ssm get-parameter --name "/myapp/settings/mysetting" --query "Parameter.Value" --output text) \
    && echo "MY_APP_SETTING=$MY_APP_SETTING" >> /etc/environment
RUN apt-get update && apt-get upgrade -y
COPY index.html /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
