#!/bin/bash

# Fetch app setting from Systems Manager Parameter Store
MY_APP_SETTING=$(aws ssm get-parameter --name "/myapp/settings/mysetting" --query "Parameter.Value" --output text)

# Set the fetched app setting as an environment variable
export MY_APP_SETTING

# Start NGINX
exec "$@"
