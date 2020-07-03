
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

CREATE UNIQUE INDEX "IX_ApiResources_Name" ON "ApiResources" ("Name");



-- ApiScopeClaims

CREATE TABLE "ApiScopeClaimsTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopeClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "ApiScopeId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId" FOREIGN KEY ("ApiScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiScopeClaims_ApiScopeId" ON "ApiScopeClaims" ("ApiScopeId");



-- ApiScopes

CREATE TABLE "ApiScopesTemp" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopes" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Required" INTEGER NOT NULL,
    "Emphasize" INTEGER NOT NULL,
    "ShowInDiscoveryDocument" INTEGER NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiScopes_ApiResourceId" ON "ApiScopes" ("ApiResourceId");

CREATE UNIQUE INDEX "IX_ApiScopes_Name" ON "ApiScopes" ("Name");



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

CREATE UNIQUE INDEX "IX_Clients_ClientId" ON "Clients" ("ClientId");