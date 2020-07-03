
-- Add New Tables
 
 
-- Add ApiResourceScopes

CREATE TABLE "ApiResourceScopes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResourceScopes" PRIMARY KEY AUTOINCREMENT,
    "Scope" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiResourceScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceScopes_ApiResourceId" ON "ApiResourceScopes" ("ApiResourceId");



-- Add ApiScopeProperties

CREATE TABLE "ApiScopeProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopeProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ScopeId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopeProperties_ApiScopes_ScopeId" FOREIGN KEY ("ScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiScopeProperties_ScopeId" ON "ApiScopeProperties" ("ScopeId");



-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE "ApiResourceClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResourceClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiResourceClaims_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceClaims_ApiResourceId" ON "ApiResourceClaims" ("ApiResourceId");



-- ApiResourceProperties

CREATE TABLE "ApiResourceProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResourceProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiResourceProperties_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceProperties_ApiResourceId" ON "ApiResourceProperties" ("ApiResourceId");



-- Add ApiResourceSecrets

CREATE TABLE "ApiResourceSecrets" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResourceSecrets" PRIMARY KEY AUTOINCREMENT,
    "Description" TEXT NULL,
    "Value" TEXT NOT NULL,
    "Expiration" TEXT NULL,
    "Type" TEXT NOT NULL,
    "Created" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiResourceSecrets_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceSecrets_ApiResourceId" ON "ApiResourceSecrets" ("ApiResourceId");



-- IdentityResourceClaims

CREATE TABLE "IdentityResourceClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_IdentityResourceClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "IdentityResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_IdentityResourceClaims_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_IdentityResourceClaims_IdentityResourceId" ON "IdentityResourceClaims" ("IdentityResourceId");



-- IdentityResourceProperties

CREATE TABLE "IdentityResourceProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_IdentityResourceProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "IdentityResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_IdentityResourceProperties_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_IdentityResourceProperties_IdentityResourceId" ON "IdentityResourceProperties" ("IdentityResourceId");



-- Add Temporary Tables

-- ApiResources

CREATE TABLE "ApiResourcesTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResources" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Created" TEXT NOT NULL,
    "Updated" TEXT NULL,
    "LastAccessed" TEXT NULL,
    "NonEditable" INTEGER NOT NULL
);



-- ApiScopeClaims

CREATE TABLE "ApiScopeClaimsTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopeClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "ApiScopeId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId" FOREIGN KEY ("ApiScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);



-- ApiScopes

CREATE TABLE "ApiScopesTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopes" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Required" INTEGER NOT NULL,
    "Emphasize" INTEGER NOT NULL,
    "ShowInDiscoveryDocument" INTEGER NOT NULL
);



-- Clients

CREATE TABLE "ClientsTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Clients" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "ClientId" TEXT NOT NULL,
    "ProtocolType" TEXT NOT NULL,
    "RequireClientSecret" INTEGER NOT NULL,
    "ClientName" TEXT NULL,
    "Description" TEXT NULL,
    "ClientUri" TEXT NULL,
    "LogoUri" TEXT NULL,
    "RequireConsent" INTEGER NOT NULL,
    "AllowRememberConsent" INTEGER NOT NULL,
    "AlwaysIncludeUserClaimsInIdToken" INTEGER NOT NULL,
    "RequirePkce" INTEGER NOT NULL,
    "AllowPlainTextPkce" INTEGER NOT NULL,
    "AllowAccessTokensViaBrowser" INTEGER NOT NULL,
    "FrontChannelLogoutUri" TEXT NULL,
    "FrontChannelLogoutSessionRequired" INTEGER NOT NULL,
    "BackChannelLogoutUri" TEXT NULL,
    "BackChannelLogoutSessionRequired" INTEGER NOT NULL,
    "AllowOfflineAccess" INTEGER NOT NULL,
    "IdentityTokenLifetime" INTEGER NOT NULL,
    "AccessTokenLifetime" INTEGER NOT NULL,
    "AuthorizationCodeLifetime" INTEGER NOT NULL,
    "ConsentLifetime" INTEGER NULL,
    "AbsoluteRefreshTokenLifetime" INTEGER NOT NULL,
    "SlidingRefreshTokenLifetime" INTEGER NOT NULL,
    "RefreshTokenUsage" INTEGER NOT NULL,
    "UpdateAccessTokenClaimsOnRefresh" INTEGER NOT NULL,
    "RefreshTokenExpiration" INTEGER NOT NULL,
    "AccessTokenType" INTEGER NOT NULL,
    "EnableLocalLogin" INTEGER NOT NULL,
    "IncludeJwtId" INTEGER NOT NULL,
    "AlwaysSendClientClaims" INTEGER NOT NULL,
    "ClientClaimsPrefix" TEXT NULL,
    "PairWiseSubjectSalt" TEXT NULL,
    "Created" TEXT NOT NULL,
    "Updated" TEXT NULL,
    "LastAccessed" TEXT NULL,
    "UserSsoLifetime" INTEGER NULL,
    "UserCodeType" TEXT NULL,
    "DeviceCodeLifetime" INTEGER NOT NULL,
    "NonEditable" INTEGER NOT NULL
);



-- Transform Data

--ApiClaims -> ApiResourceClaims

INSERT INTO "ApiResourceClaims"
 ("Id", "Type", "ApiResourceId")
SELECT 
 "Id", "Type", "ApiResourceId"
FROM "ApiClaims";



--ApiProperties -> ApiResourceProperties

INSERT INTO "ApiResourceProperties"
 ("Id", "Key", "Value", "ApiResourceId")
SELECT 
 "Id", "Key", "Value", "ApiResourceId"
FROM "ApiProperties";



--ApiSecrets -> ApiResourceSecrets

INSERT INTO "ApiResourceSecrets"
 ("Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId")
SELECT 
 "Id", "Description", "Value", "Expiration", "Type", "Created", "ApiResourceId"
FROM "ApiSecrets";



--IdentityClaims -> IdentityResourceClaims

INSERT INTO "IdentityResourceClaims"
 ("Id", "Type", "IdentityResourceId")
SELECT 
 "Id", "Type", "IdentityResourceId"
FROM "IdentityClaims";



--IdentityProperties -> IdentityResourceProperties

INSERT INTO "IdentityResourceProperties"
 ("Id", "Key", "Value", "IdentityResourceId")
SELECT 
 "Id", "Key", "Value", "IdentityResourceId"
FROM "IdentityProperties";



-- ApiResources -> ApiResourcesTemp

INSERT INTO "ApiResourcesTemp"
 ("Id", "Enabled", "Name", "DisplayName",
  "Description", "Created", "Updated",
  "LastAccessed", "NonEditable")
SELECT 
 "Id", "Enabled", "Name", "DisplayName",
 "Description", "Created", "Updated",
 "LastAccessed", "NonEditable"
FROM "ApiResources"; 

ALTER TABLE "ApiResources"
  RENAME TO "ApiResources_Backup";
  
ALTER TABLE "ApiResourcesTemp"
  RENAME TO "ApiResources";
  
  
DROP INDEX IF EXISTS "IX_ApiResources_Name";
CREATE UNIQUE INDEX "IX_ApiResources_Name" ON "ApiResources" ("Name");



-- ApiScopeClaims -> ApiScopeClaimsTemp

INSERT INTO "ApiScopeClaimsTemp"
 ("Id", "Type", "ApiScopeId")
SELECT 
 "Id", "Type", "ApiScopeId"
FROM "ApiScopeClaims";

ALTER TABLE ApiScopeClaims
  RENAME TO ApiScopeClaims_Backup;
  
ALTER TABLE ApiScopeClaimsTemp
  RENAME TO ApiScopeClaims;
  
DROP INDEX IF EXISTS "IX_ApiScopeClaims_ApiScopeId";
CREATE INDEX "IX_ApiScopeClaims_ApiScopeId" ON "ApiScopeClaims" ("ApiScopeId");



-- ApiScopes -> ApiScopesTemp

INSERT INTO "ApiScopesTemp"
   ("Id", "Name", "DisplayName",
    "Description", "Required","Emphasize",
    "ShowInDiscoveryDocument")
SELECT 
   "Id", "Name", "DisplayName",
   "Description", "Required","Emphasize",
   "ShowInDiscoveryDocument"
FROM "ApiScopes";

ALTER TABLE ApiScopes
  RENAME TO ApiScopes_Backup;
  
ALTER TABLE ApiScopesTemp
  RENAME TO ApiScopes;

  
DROP INDEX IF EXISTS "IX_ApiScopes_ApiResourceId";
CREATE INDEX "IX_ApiScopes_ApiResourceId" ON "ApiScopes" ("ApiResourceId");

DROP INDEX IF EXISTS "IX_ApiScopes_Name";
CREATE UNIQUE INDEX "IX_ApiScopes_Name" ON "ApiScopes" ("Name");


INSERT INTO "ApiResourceScopes"
 ("Scope", "ApiResourceId")
SELECT 
 "Name", "ApiResourceId"
FROM "ApiScopes"



-- Clients -> ClientsTemp

INSERT INTO "ClientsTemp"
   ("Id", "Enabled", "ClientId", "ProtocolType", "RequireClientSecret",
    "ClientName", "Description", "ClientUri", "LogoUri", "RequireConsent",
    "AllowRememberConsent", "AlwaysIncludeUserClaimsInIdToken", "RequirePkce",
    "AllowPlainTextPkce", "AllowAccessTokensViaBrowser", "FrontChannelLogoutUri",
    "FrontChannelLogoutSessionRequired", "BackChannelLogoutUri", "BackChannelLogoutSessionRequired",
    "AllowOfflineAccess", "IdentityTokenLifetime", "AccessTokenLifetime",
    "AuthorizationCodeLifetime", "ConsentLifetime", "AbsoluteRefreshTokenLifetime",
    "SlidingRefreshTokenLifetime", "RefreshTokenUsage", "UpdateAccessTokenClaimsOnRefresh",
    "RefreshTokenExpiration", "AccessTokenType", "EnableLocalLogin", "IncludeJwtId",
    "AlwaysSendClientClaims", "ClientClaimsPrefix", "PairWiseSubjectSalt", "Created",
    "Updated", "LastAccessed", "UserSsoLifetime", "UserCodeType", "DeviceCodeLifetime",
    "NonEditable")
SELECT 
   "Id", "Enabled", "ClientId", "ProtocolType", "RequireClientSecret",
    "ClientName", "Description", "ClientUri", "LogoUri", "RequireConsent",
    "AllowRememberConsent", "AlwaysIncludeUserClaimsInIdToken", "RequirePkce",
    "AllowPlainTextPkce", "AllowAccessTokensViaBrowser", "FrontChannelLogoutUri",
    "FrontChannelLogoutSessionRequired", "BackChannelLogoutUri", "BackChannelLogoutSessionRequired",
    "AllowOfflineAccess", "IdentityTokenLifetime", "AccessTokenLifetime",
    "AuthorizationCodeLifetime", "ConsentLifetime", "AbsoluteRefreshTokenLifetime",
    "SlidingRefreshTokenLifetime", "RefreshTokenUsage", "UpdateAccessTokenClaimsOnRefresh",
    "RefreshTokenExpiration", "AccessTokenType", "EnableLocalLogin", "IncludeJwtId",
    "AlwaysSendClientClaims", "ClientClaimsPrefix", "PairWiseSubjectSalt", "Created",
    "Updated", "LastAccessed", "UserSsoLifetime", "UserCodeType", "DeviceCodeLifetime",
    "NonEditable"
FROM "Clients";

ALTER TABLE Clients
  RENAME TO Clients_Backup;
  
ALTER TABLE ClientsTemp
  RENAME TO Clients;

DROP INDEX IF EXISTS "IX_Clients_ClientId";
CREATE UNIQUE INDEX "IX_Clients_ClientId" ON "Clients" ("ClientId"); 

 

-- Delete Old Tables

-- DROP TABLE "ApiClaims";
-- DROP TABLE "ApiProperties";
-- DROP TABLE "ApiSecrets";
-- DROP TABLE "IdentityClaims";
-- DROP TABLE "IdentityProperties";



-- Delete Backup Tables

-- DROP TABLE "ApiResources_Backup";
-- DROP TABLE "ApiScopeClaims_Backup";
-- DROP TABLE "ApiScopes_Backup";
-- DROP TABLE "Clients_Backup";
