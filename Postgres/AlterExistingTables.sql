
-- Alter tables

-- ApiResources

ALTER TABLE "ApiResources"
	ADD "AllowedAccessTokenSigningAlgorithms" character varying (100)
	NULL
	
ALTER TABLE "ApiResources"
	ADD "ShowInDiscoveryDocument" BOOLEAN
	NULL
	
UPDATE "ApiResources" SET "ShowInDiscoveryDocument" = FALSE

ALTER TABLE "ApiResources"
	ALTER COLUMN "ShowInDiscoveryDocument" BIT NOT NULL
	
	

-- ApiScopeClaims

ALTER TABLE "ApiScopeClaims"
	DROP CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId"
	
DROP INDEX "IX_ApiScopeClaims_ApiScopeId"
	ON "ApiScopeClaims"
		
ALTER TABLE "ApiScopeClaims" RENAME "ApiScopeId" TO "ScopeId"

CREATE INDEX "IX_ApiScopeClaims_ScopeId" ON "ApiScopeClaims" ("ScopeId")

ALTER TABLE "ApiScopeClaims"
	ADD CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ScopeId" 
	FOREIGN KEY ("ScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
	

	
-- ApiScopes

ALTER TABLE "ApiScopes"
	DROP CONSTRAINT "FK_ApiScopes_ApiResources_ApiResourceId"
	
DROP INDEX "IX_ApiScopes_ApiResourceId"
	ON "ApiScopes"

ALTER TABLE "ApiScopes"
	ADD "Enabled" BOOLEAN NULL

UPDATE "ApiScopes" SET "Enabled" = TRUE

ALTER TABLE "ApiResources"
	ALTER COLUMN "Enabled" BOOLEAN NOT NULL
	
	
	
-- Clients

ALTER TABLE "Clients"
	ADD "AllowedIdentityTokenSigningAlgorithms" character varying(100) NULL
	
ALTER TABLE "Clients"
	ADD "RequireRequestObject" BOOLEAN NULL
	
UPDATE Clients SET "RequireRequestObject" = FALSE
	
ALTER TABLE "Clients"
	ALTER COLUMN "RequireRequestObject" BOOLEAN NOT NULL

	

-- DeviceCodes

ALTER TABLE "DeviceCodes"
	ADD "SessionId" character varying(100) NULL
	
ALTER TABLE "DeviceCodes"
	ADD "Description" character varying(200) NULL



-- PersistedGrants

ALTER TABLE "PersistedGrants"
	ADD "SessionId" character varying(100) NULL
	
ALTER TABLE "PersistedGrants"
	ADD "Description" character varying(200) NULL
	
ALTER TABLE "PersistedGrants"
	ADD "ConsumedTime" timestamp without time zone NULL

CREATE INDEX "IX_PersistedGrants_SubjectId_SessionId_Type" ON "PersistedGrants" ("SubjectId", "SessionId", "Type")