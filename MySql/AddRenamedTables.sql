
-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE `ApiResourceClaims` (
    `Id` int NOT NULL,
    `Type` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceClaims_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceClaims_ApiResourceId` ON `ApiResourceClaims` (`ApiResourceId`);



-- ApiResourceProperties

CREATE TABLE `ApiResourceProperties` (
    `Id` int NOT NULL,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceProperties_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceProperties_ApiResourceId` ON `ApiResourceProperties` (`ApiResourceId`);



-- Add ApiResourceSecrets

CREATE TABLE `ApiResourceSecrets` (
    `Id` int NOT NULL,
    `Description` nvarchar(1000) NULL,
    `Value` nvarchar(4000) NOT NULL,
    `Expiration` datetime2(6) NULL,
    `Type` nvarchar(250) NOT NULL,
    `Created` datetime2(6) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceSecrets` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceSecrets_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceSecrets_ApiResourceId` ON `ApiResourceSecrets` (`ApiResourceId`);



-- IdentityResourceClaims

CREATE TABLE `IdentityResourceClaims` (
    `Id` int NOT NULL,
    `Type` nvarchar(200) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceClaims_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceClaims_IdentityResourceId` ON `IdentityResourceClaims` (`IdentityResourceId`);



-- IdentityResourceProperties

CREATE TABLE `IdentityResourceProperties` (
    `Id` int NOT NULL,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceProperties_IdentityResources_IdentityResource` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceProperties_IdentityResourceId` ON `IdentityResourceProperties` (`IdentityResourceId`);
