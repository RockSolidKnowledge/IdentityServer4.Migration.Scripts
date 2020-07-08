BEGIN TRANSACTION

--Add New Tables

-- Add ApiResourceScopes

CREATE TABLE ApiResourceScopes (
    Id             INT            IDENTITY (1, 1) NOT NULL,
    Scope          NVARCHAR (200) NOT NULL,
    ApiResourceId  INT            NOT NULL,
    CONSTRAINT PK_ApiResourceScopes PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceScopes_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiResourceScopes_ApiResourceId
    ON ApiResourceScopes(ApiResourceId ASC);
GO



-- Add ApiScopeProperties

CREATE TABLE ApiScopeProperties (
    Id        INT             IDENTITY (1, 1) NOT NULL,
    [Key]     NVARCHAR (250)  NOT NULL,
    [Value]   NVARCHAR (2000) NOT NULL,
    ScopeId   INT             NOT NULL,
    CONSTRAINT PK_ApiScopeProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiScopeProperties_ApiScopes_ScopeId FOREIGN KEY (ScopeId) REFERENCES ApiScopes (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiScopeProperties_ScopeId
    ON ApiScopeProperties(ScopeId ASC);
GO



-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE [dbo].[ApiResourceClaims] (
    Id              INT            IDENTITY (1, 1) NOT NULL,
    [Type]          NVARCHAR (200) NOT NULL,
    ApiResourceId   INT            NOT NULL,
    CONSTRAINT PK_ApiResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceClaims_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_ApiResourceClaims_ApiResourceId]
    ON [dbo].[ApiResourceClaims]([ApiResourceId] ASC);
GO



-- ApiResourceProperties

CREATE TABLE [dbo].[ApiResourceProperties] (
    [Id]            INT             IDENTITY (1, 1) NOT NULL,
    [Key]           NVARCHAR (250)  NOT NULL,
    [Value]         NVARCHAR (2000) NOT NULL,
    ApiResourceId   INT             NOT NULL,
    CONSTRAINT PK_ApiResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceProperties_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_ApiResourceProperties_ApiResourceId]
    ON [dbo].[ApiResourceProperties]([ApiResourceId] ASC);
GO



-- Add ApiResourceSecrets

CREATE TABLE ApiResourceSecrets (
    Id              INT             IDENTITY (1, 1) NOT NULL,
    [Description]   NVARCHAR (1000) NULL,
    [Value]         NVARCHAR (4000) NOT NULL,
    Expiration      DATETIME2 (7)   NULL,
    [Type]          NVARCHAR (250)  NOT NULL,
    Created         DATETIME2 (7)   NOT NULL,
    ApiResourceId   INT             NOT NULL,
    CONSTRAINT PK_ApiResourceSecrets PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_ApiResourceSecrets_ApiResources_ApiResourceId FOREIGN KEY (ApiResourceId) REFERENCES ApiResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_ApiResourceSecrets_ApiResourceId
    ON ApiResourceSecrets(ApiResourceId ASC);
GO



-- IdentityResourceClaims

CREATE TABLE IdentityResourceClaims (
    Id                 INT            IDENTITY (1, 1) NOT NULL,
    [Type]             NVARCHAR (200) NOT NULL,
    IdentityResourceId INT            NOT NULL,
    CONSTRAINT PK_IdentityResourceClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceClaims_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_IdentityResourceClaims_IdentityResourceId]
    ON IdentityResourceClaims(IdentityResourceId ASC);
GO



-- IdentityResourceProperties

CREATE TABLE IdentityResourceProperties (
    Id                   INT             IDENTITY (1, 1) NOT NULL,
    [Key]                NVARCHAR (250)  NOT NULL,
    [Value]              NVARCHAR (2000) NOT NULL,
    IdentityResourceId   INT             NOT NULL,
    CONSTRAINT PK_IdentityResourceProperties PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT FK_IdentityResourceProperties_IdentityResources_IdentityResourceId FOREIGN KEY (IdentityResourceId) REFERENCES IdentityResources (Id) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX IX_IdentityResourceProperties_IdentityResourceId
    ON IdentityResourceProperties(IdentityResourceId ASC);
GO



-- Migrate Existing Data

--ApiClaims -> ApiResourceClaims
SET IDENTITY_INSERT ApiResourceClaims ON;


INSERT INTO ApiResourceClaims
 (Id, [Type], ApiResourceId)
SELECT 
 Id, [Type], ApiResourceId
FROM ApiClaims


SET IDENTITY_INSERT ApiResourceClaims OFF;


--ApiProperties -> ApiResourceProperties
SET IDENTITY_INSERT ApiResourceProperties ON;  
GO

INSERT INTO ApiResourceProperties
 (Id, [Key], [Value], ApiResourceId)
SELECT 
 Id, [Key], [Value], ApiResourceId
FROM ApiProperties
GO

SET IDENTITY_INSERT ApiResourceProperties OFF;
GO

--ApiSecrets -> ApiResourceSecrets
SET IDENTITY_INSERT ApiResourceSecrets ON;  
GO

INSERT INTO ApiResourceSecrets
 (Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId)
SELECT 
 Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId
FROM ApiSecrets
GO

SET IDENTITY_INSERT ApiResourceSecrets OFF;  
GO


--IdentityClaims -> IdentityResourceClaims
SET IDENTITY_INSERT IdentityResourceClaims ON;  
GO

INSERT INTO IdentityResourceClaims
 (Id, [Type], IdentityResourceId)
SELECT 
 Id, [Type], IdentityResourceId
FROM IdentityClaims
GO

SET IDENTITY_INSERT IdentityResourceClaims OFF;  
GO



--IdentityProperties -> IdentityResourceProperties
SET IDENTITY_INSERT IdentityResourceProperties ON;  
GO

INSERT INTO IdentityResourceProperties
 (Id, [Key], [Value], IdentityResourceId)
SELECT 
 Id, [Key], [Value], IdentityResourceId
FROM IdentityProperties
GO

SET IDENTITY_INSERT IdentityResourceProperties OFF;  
GO


-- ApiScopes -> ApiResourceScopes

INSERT INTO ApiResourceScopes 
 ([Scope], [ApiResourceId])
SELECT 
 [Name], [ApiResourceId]
FROM ApiScopes

-- Alter Existing Tables

-- ApiResources

ALTER TABLE ApiResources 
	ADD AllowedAccessTokenSigningAlgorithms NVARCHAR (100)
	NULL
	
ALTER TABLE ApiResources 
	ADD ShowInDiscoveryDocument BIT
	NULL
GO
	
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
	ADD [Enabled] BIT NULL

GO

UPDATE ApiScopes SET [Enabled] = 1

ALTER TABLE ApiScopes
	DROP COLUMN ApiResourceId;

ALTER TABLE ApiScopes 
	ALTER COLUMN Enabled BIT NOT NULL;



-- Clients

ALTER TABLE Clients
	ADD AllowedIdentityTokenSigningAlgorithms NVARCHAR (100) NULL
	
ALTER TABLE Clients
	ADD RequireRequestObject BIT NULL
GO

UPDATE Clients SET RequireRequestObject = 0
	
ALTER TABLE Clients
	ALTER COLUMN RequireRequestObject BIT NOT NULL

	

-- Delete Old Tables

--DROP TABLE ApiClaims
--DROP TABLE ApiProperties
--DROP TABLE ApiSecrets
--DROP TABLE IdentityClaims
--DROP TABLE IdentityProperties

COMMIT TRANSACTION