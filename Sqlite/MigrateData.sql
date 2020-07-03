-- Transform Data

--ApiClaims -> ApiResourceClaims

INSERT INTO "ApiResourceClaims"
 ("Id", "Type", "ApiResourceId")
SELECT 
 "Id", "Type", "ApiResourceId"
FROM "ApiClaims"



--ApiProperties -> ApiResourceProperties

INSERT INTO "ApiResourceProperties"
 ("Id", "Key", "Value", "ApiResourceId")
SELECT 
 "Id", "Key", "Value", "ApiResourceId"
FROM "ApiProperties"



--ApiSecrets -> ApiResourceSecrets

INSERT INTO "ApiResourceSecrets"
 ("Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId")
SELECT 
 "Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId"
FROM "ApiSecrets"



--IdentityClaims -> IdentityResourceClaims

INSERT INTO "IdentityResourceClaims"
 ("Id", "Type", "IdentityResourceId")
SELECT 
 "Id", "Type", "IdentityResourceId"
FROM "IdentityClaims"



--IdentityProperties -> IdentityResourceProperties

INSERT INTO "IdentityResourceProperties"
 ("Id", "Key", "Value", "IdentityResourceId")
SELECT 
 "Id", "Key", "Value", "IdentityResourceId"
FROM "IdentityProperties"



-- ApiResources -> ApiResourcesTemp

INSERT INTO "ApiResourcesTemp"
 ("Id", "Enabled", "Name", "DisplayName"
  "Description", "Created", "Updated"
  "LastAccessed", "NonEditable")
SELECT 
 "Id", "Enabled", "Name", "DisplayName"
 "Description", "Created", "Updated"
 "LastAccessed", "NonEditable"
FROM "ApiResources"

ALTER TABLE ApiResources
  RENAME TO ApiResources_Backup;
  
ALTER TABLE ApiResourcesTemp
  RENAME TO ApiResources;
  
  

-- ApiScopeClaims -> ApiScopeClaimsTemp

INSERT INTO "ApiScopeClaimsTemp"
 ("Id", "Type", "ApiScopeId")
SELECT 
 "Id", "Type", "ApiScopeId"
FROM "ApiScopeClaims"

ALTER TABLE ApiScopeClaims
  RENAME TO ApiScopeClaims_Backup;
  
ALTER TABLE ApiScopeClaimsTemp
  RENAME TO ApiScopeClaims;
  
  

-- ApiScopes -> ApiScopesTemp

INSERT INTO "ApiScopesTemp"
   ("Id", "Name", "DisplayName",
    "Description", "Required","Emphasize",
    "ShowInDiscoveryDocument", "ApiResourceId")
SELECT 
   "Id", "Name", "DisplayName",
   "Description", "Required","Emphasize",
   "ShowInDiscoveryDocument", "ApiResourceId"
FROM "ApiScopes"

ALTER TABLE ApiScopes
  RENAME TO ApiScopes_Backup;
  
ALTER TABLE ApiScopesTemp
  RENAME TO ApiScopes;



-- Clients -> ClientsTemp

INSERT INTO "ClientsTemp"
   ("Id", "Name", "DisplayName",
    "Description", "Required","Emphasize",
    "ShowInDiscoveryDocument", "ApiResourceId")
SELECT 
   "Id", "Name", "DisplayName",
   "Description", "Required","Emphasize",
   "ShowInDiscoveryDocument", "ApiResourceId"
FROM "Clients"

ALTER TABLE Clients
  RENAME TO Clients_Backup;
  
ALTER TABLE ClientsTemp
  RENAME TO Clients;
  