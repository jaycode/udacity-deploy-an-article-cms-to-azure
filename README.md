# Article CMS (FlaskWebProject)

This project is a Python web application built using Flask. The user can log in and out and create/edit articles. An article consists of a title, author, and body of text stored in an Azure SQL Server along with an image that is stored in Azure Blob Storage. You will also implement OAuth2 with Sign in with Microsoft using the `msal` library, along with app logging.

## Log In Credentials for FlaskWebProject

- Username: admin
- Password: pass

Or, once the MS Login button is implemented, it will automatically log into the `admin` account.

## Quick Tutorial with sample values

Edit `credentials.sh` with credentials as you go through the items below.

## Resource Group
- Resource Group Name: cms

## SQL Database
- DB name: cms
- Server: cms.database.windows.net
- DB region: us-east
- Admin login: cmsadmin
- Admin password: CMS4dmin
- Resource group: cms
- DB workload env: Development
- DB compute + storage: DTU - Basic
- Press the "Next: Networking" button, then select "Public Endpoint", and set both of the Firewall rules that appear to "Yes".
- Set everything else to default
- **Run SQL queries in sql_scripts/ directory after completion, starting from the users table. Don't forget to take screenshots.**

## Storage Account
- Resource group: cms
- Storage account name: images11 (needs to be unique)
- Advanced - Allow enabling anonymous access on individual containers: Enable
- Advanced - Access tier: Cool
- Network access: Enable public access from all networks (the default)
- On the "Networking" page, click on "Add your client IP address" link
- Create container named "images". Set its access level to Container.
- Blob Storage key: 8vNfUqGqnND0GI1Yujdd17gwURdEyBwVsFfKuiwZJdByu8DEWhHc2R1RYcQFxxUX2vqx72OXiz2
- Blob connection string: DefaultEndpointsProtocol=https;AccountName=images11;AccountKey=8vNfUqGqnND0GI1Yujdd17gwURdEyBwVsFfKuiwZJdByu8DEWhHc2R1RYcQFxxUX2vqx72OXiz2/+AStSydbYA==;EndpointSuffix=core.windows.net

## Microsoft Entra ID
### App Registration
- Name: cmsEntraID
- Who can use? "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)"

### Secret Creation
- Secret description: cmsSecret
- Secret Key: 3a51cadc-dc5f-4503-959d-d4286f24d7a4
- Client Secret: wN48Q~SVo5ecjrNs-Fac1wvs9cRVgXVYPxEmjc.r
- Application (client) ID: 1660e7a3-74ae-4945-aea0-5bd962871c33

## OPTION 1: Virtual Machine
- Name: vm-cms
- Authentication type: Password
- Username: cmsUser
- Password: cmsP4ssw0rd111
- Size: Standard B1ls (the cheapest)
- Ubuntu 24.04
- Select inbound ports: Choose 80, 443, and 22
  1. Connect to VM via SSH
  2. Setup GitHub SSH key
    - `ssh-keygen -t ed25519 -C "yourgithubemail@example.com"`
    - Press enter on the next few prompts
    - `eval "$(ssh-agent -s)"`
    - `ssh-add ~/.ssh/id_ed25519`
    - `cat ~/.ssh/id_ed25519.pub`
    - Copy the output to https://github.com/settings/keys
  3. Setup the website:
    - Setup HTTPS:
      - `sudo mkdir -p /etc/nginx/ssl`
      - `sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt`
      - Any values are accepted for the next questions. Here is an example:
        Country Name (2 letter code) [AU]:US
        State or Province Name (full name) [Some-State]:California
        Locality Name (eg, city) []:Palo Alto
        Organization Name (eg, company) [Internet Widgits Pty Ltd]:
        Organizational Unit Name (eg, section) []:
        Common Name (e.g. server FQDN or YOUR name) []:
        Email Address []:hello@example.com
    - `sudo curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list`
    - `sudo apt update`
    - `git clone [git@github.com:user/repo.git] web`
    - `sudo apt -y update && sudo apt-get -y install nginx python3-venv unixodbc unixodbc-dev`
    - `sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17`
    - `sudo unlink /etc/nginx/sites-enabled/default`
    - `sudo vim /etc/nginx/sites-available/reverse-proxy.conf`
    - Paste this code into reverse-proxy.conf (don't include the initial and last lines with three backticks):
    ```bash
    server {
    listen 80;
    location / {
    proxy_pass https://localhost:5555;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection keep-alive;
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
    }
    }
    server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;
    location / {
    proxy_pass https://localhost:5555;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection keep-alive;
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
    }
    }
    ```

    - `sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf`
    - `sudo service nginx restart`
    - `cd ~/web`
    - `python3 -m venv venv`
    - `. venv/bin/activate`
    - `pip install --upgrade pip`
    - `pip install -r requirements.txt`
    - Copy-paste the code from `credentials.sh` to the terminal
    - `python application.py`


## OPTION 2: Web App - TODO
- Name: cms-d3etfkhudcfka0gm.eastus-01.azurewebsites.net
- Runtime stack: Python 3.10
- Pricing Plan: Free F1
- Deployment - Basic authentication: Enable
- TODO

## Microsoft Entra ID again
Go to App Registrations, click on the App Registration created earlier, then pick Authentication from the left sidebar.

### Authentication - Add a Platform - Web
- Redirect URIs: https://[IP ADDRESS FROM VM]/getAToken
- logout URL: https://[IP ADDRESS FROM VM]/login