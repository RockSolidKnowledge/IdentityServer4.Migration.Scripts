
-- Add ApiResourceScopes

CREATE TABLE `ApiResourceScopes` (
    `Id` int NOT NULL,
    `Scope` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceScopes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceScopes_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceScopes_ApiResourceId` ON `ApiResourceScopes` (`ApiResourceId`);



-- Add ApiScopeProperties

CREATE TABLE `ApiScopeProperties` (
    `Id` int NOT NULL,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ScopeId` int NOT NULL,
    CONSTRAINT `PK_ApiScopeProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopeProperties_ApiScopes_ScopeId` FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiScopeProperties_ScopeId` ON `ApiScopeProperties` (`ScopeId`);

