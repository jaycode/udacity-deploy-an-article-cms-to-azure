Resource Group Name: cms

SQL Database
DB name: cms
Server: cms.database.windows.net
DB region: us-east
Admin login: ***
Admin password: ***
Resource group: cms
DB workload env: Development
DB compute + storage: DTU - Basic
Press the "Next: Networking" button, then select "Public Endpoint", and set both of the Firewall rules that appear to "Yes".
Set everything else to default

Storage Account
Resource group: cms
Storage account name: images11 (needs to be unique)
Advanced - Access tier: Cool
Network access: Enable public access from all networks (the default)
On the "Networking" page, click on "Add your client IP address" link
Create container named "images"
Storage key: ***
Storage connection string: ***

Microsoft Entra ID
App Registration
Name: cmsEntraID
Who can use? "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)"
Application (client) ID: ***
Secret description: cmsSecret
Secret Value: ***
Secret ID: ***

OPTION 1: Virtual Machine
Name: vm-cms
Authentication type: Password
Username: ***
Password: ***
Size: Standard B1ls (the cheapest)
Networking - Select inbound ports: Choose 80 and 22
Connect to VM via SSH, setup and pull GitHub repo, then setup the website.


OPTION 2: Web App
Name: ***
Runtime stack: Python 3.10
Pricing Plan: Free F1
Deployment - Basic authentication: Enable