# 1. Update with actual credentials and rename to credentials.sh
# 2. Send the code to your VM via SSH (can be by copy pasting to Azure CLI)
export BLOB_ACCOUNT="your_blob_account_here"
export BLOB_CONTAINER="your_blob_container_here"
export BLOB_STORAGE_KEY="your_blob_storage_key_here"
export BLOB_CONNECTION_STRING="your_blob_connection_string_here"
export SQL_SERVER="cms.database.windows.net"
export SQL_DATABASE="cms"
export SQL_USER_NAME="cmsadmin"
export SQL_PASSWORD="CMS4dmin"
# Secret Value in Azure
export CLIENT_SECRET="your_client_secret_here"
# Secret ID in Azure
export SECRET_KEY="your_secret_key_here"
# Application (client) ID in Azure
export CLIENT_ID="your_client_id_here"