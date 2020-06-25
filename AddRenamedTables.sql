
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

