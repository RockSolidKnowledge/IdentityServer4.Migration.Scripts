
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

