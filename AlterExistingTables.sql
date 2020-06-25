
-- Alter tables

-- ApiResources

ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BIT
	CONSTRAINT ApiResources_Default_Disco DEFAULT (0)
	NOT NULL

ALTER TABLE ApiResources 
	DROP CONSTRAINT ApiResources_Default_Disco



-- ApiScopeClaims

ALTER TABLE ApiScopeClaims
	DROP CONSTRAINT FK_ApiScopeClaims_ApiScopes_ApiScopeId
	
DROP INDEX IX_ApiScopeClaims_ApiScopeId
	ON ApiScopeClaims
	
exec sp_rename 'ApiScopeClaims.ApiScopeId', 'ScopeId', 'COLUMN';

CREATE NONCLUSTERED INDEX IX_ApiScopeClaims_ScopeId
    ON ApiScopeClaims(ScopeId ASC);
	
ALTER TABLE ApiScopeClaims
	ADD CONSTRAINT FK_ApiScopeClaims_ApiScopes_ScopeId 
	FOREIGN KEY (ScopeId) REFERENCES ApiScopes (Id) ON DELETE CASCADE
	
	
	
-- ApiScopes

ALTER TABLE ApiScopes
	ADD [Enabled] BIT
	CONSTRAINT ApiScopes_Default_Enabled DEFAULT(0)
	NOT NULL

ALTER TABLE ApiScopes 
	DROP CONSTRAINT ApiScopes_Default_Enabled

	
ALTER TABLE ApiScopes
	DROP CONSTRAINT FK_ApiScopes_ApiResources_ApiResourceId
	
DROP INDEX IX_ApiScopes_ApiResourceId
	ON ApiScopes
	


-- Clients

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT 
	CONSTRAINT Clients_Default_RequireRequestObject DEFAULT (0)
	NOT NULL
	
ALTER TABLE Clients
	DROP CONSTRAINT Clients_Default_RequireRequestObject
	


-- DeviceCodes

ALTER TABLE DeviceCodes
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE DeviceCodes
	ADD [Description] NVARCHAR (200) NULL



-- PersistedGrants

ALTER TABLE PersistedGrants
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD [Description] NVARCHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime DATETIME2 (7) NULL

CREATE NONCLUSTERED INDEX IX_PersistedGrants_SubjectId_SessionId_Type
    ON PersistedGrants(SubjectId ASC, SessionId ASC, Type ASC);

