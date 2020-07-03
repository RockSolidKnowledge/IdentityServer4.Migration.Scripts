
-- Alter Existing Tables

-- ApiResources

ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BIT
	NULL
	
UPDATE ApiResources SET ShowInDiscoveryDocument = 0

ALTER TABLE ApiResources 
	ALTER COLUMN ShowInDiscoveryDocument BIT NOT NULL



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
	DROP CONSTRAINT FK_ApiScopes_ApiResources_ApiResourceId
	
DROP INDEX IX_ApiScopes_ApiResourceId
	ON ApiScopes

ALTER TABLE ApiScopes
DROP COLUMN ApiResourceId;
	
ALTER TABLE ApiScopes 
	ADD Enabled BIT NULL

UPDATE ApiScopes SET Enabled = 1

ALTER TABLE ApiScopes
	ALTER COLUMN Enabled BIT NOT NULL



-- Clients

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT NULL
	
UPDATE Clients SET RequireRequestObject = 0
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BIT NOT NULL
	
	
	
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
	
