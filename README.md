# azure-databricks-secure-deployment
This repo showcases an example deployment pattern for DEV/TEST/PROD Azure Databricks Workspaces

It contains 3 main Terraform modules:

## azurerm-cdp-dbx-workspace
- Contains the code to deploy the workspace itself using azurerm

## cdp-account-level-components
Contains the Databricks account-level components that must be deployed using Account Admin/Metastore Admin credentials, such as:
- Account-level groups (synced from Microsoft Entra ID)
- Group membership assignments
- Account-level service principals
- Metastore/workspace assignments 
- Metastore-level grants

## cdp-workspace-level-components
Contains the Databricks workspace-level components that must be deployed using Workspace Admin credentials (along with any additinal access granted by the metasotre admin in the previous module), such as:
- External locations (and accompaning Azure Storage accounts/containers)
- Unity Catalog 
- Schemas
- Relevant Catalog/Schema-level grants