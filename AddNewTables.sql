
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

