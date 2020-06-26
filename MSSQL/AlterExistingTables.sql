
-- Alter tables

-- ApiResources

-- MSSQL
ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BIT
	NULL
	
UPDATE ApiResources SET ShowInDiscoveryDocument = 0

ALTER TABLE ApiResources 
	ALTER COLUMN ShowInDiscoveryDocument BIT NOT NULL
	
-- MySql, Postgres

ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms VARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BOOLEAN
	NULL
	
UPDATE ApiResources SET ShowInDiscoveryDocument = FALSE

ALTER TABLE ApiResources 
	ALTER COLUMN ShowInDiscoveryDocument BIT NOT NULL
	
	

-- ApiScopeClaims

ALTER TABLE ApiScopeClaims
	DROP CONSTRAINT FK_ApiScopeClaims_ApiScopes_ApiScopeId
	
DROP INDEX IX_ApiScopeClaims_ApiScopeId
	ON ApiScopeClaims
		
--MSSQL

exec sp_rename 'ApiScopeClaims.ApiScopeId', 'ScopeId', 'COLUMN';

--MySQL, Postgres

ALTER TABLE ApiScopeClaims RENAME ApiScopeId TO ScopeId


-- MSSQL, Postgres, MySql
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
	
--MSSQL

ALTER TABLE ApiScopes 
	ADD Enabled BIT NULL

UPDATE ApiScopes SET Enabled = 1

ALTER TABLE ApiResources 
	ALTER COLUMN Enabled BIT NOT NULL

-- MySql, Postgres

ALTER TABLE ApiScopes 
	ADD Enabled BOOLEAN NULL

UPDATE ApiScopes SET Enabled = TRUE

ALTER TABLE ApiResources 
	ALTER COLUMN Enabled BOOLEAN NOT NULL
	
	
	

-- Clients

--MSSQL

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT NULL
	
UPDATE Clients SET RequireRequestObject = 0
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BIT NOT NULL
	
--MySql, Posgres

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms VARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BOOLEAN NULL
	
UPDATE Clients SET RequireRequestObject = FALSE
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BOOLEAN NOT NULL
	
	

-- DeviceCodes

--MSSQL
ALTER TABLE DeviceCodes
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE DeviceCodes
	ADD [Description] NVARCHAR (200) NULL

--MySql, Posgres

ALTER TABLE DeviceCodes
	ADD SessionId VARCHAR (100) NULL
	
ALTER TABLE DeviceCodes
	ADD Description VARCHAR (200) NULL


-- PersistedGrants

--MSSQL
ALTER TABLE PersistedGrants
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD [Description] NVARCHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime DATETIME2 (7) NULL

CREATE NONCLUSTERED INDEX IX_PersistedGrants_SubjectId_SessionId_Type
    ON PersistedGrants(SubjectId ASC, SessionId ASC, Type ASC);
	
--MySql

ALTER TABLE PersistedGrants
	ADD SessionId VARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD Description CHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime TIMESTAMP (7) NULL

CREATE NONCLUSTERED INDEX IX_PersistedGrants_SubjectId_SessionId_Type
    ON PersistedGrants(SubjectId ASC, SessionId ASC, Type ASC);

--PostGres

ALTER TABLE PersistedGrants
	ADD SessionId VARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD Description VARCHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime DATETIME (7) NULL
