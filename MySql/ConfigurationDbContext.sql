START TRANSACTION;

-- Add New Tables

-- Add ApiResourceScopes

CREATE TABLE `ApiResourceScopes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Scope` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceScopes` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceScopes_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceScopes_ApiResourceId` ON `ApiResourceScopes` (`ApiResourceId`);



-- Add ApiScopeProperties

CREATE TABLE `ApiScopeProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ScopeId` int NOT NULL,
    CONSTRAINT `PK_ApiScopeProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiScopeProperties_ApiScopes_ScopeId` FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiScopeProperties_ScopeId` ON `ApiScopeProperties` (`ScopeId`);



-- Add Renamed Tables

-- ApiResourceClaims

CREATE TABLE `ApiResourceClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` nvarchar(200) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceClaims_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceClaims_ApiResourceId` ON `ApiResourceClaims` (`ApiResourceId`);



-- ApiResourceProperties

CREATE TABLE `ApiResourceProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceProperties_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceProperties_ApiResourceId` ON `ApiResourceProperties` (`ApiResourceId`);



-- Add ApiResourceSecrets

CREATE TABLE `ApiResourceSecrets` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Description` nvarchar(1000) NULL,
    `Value` nvarchar(4000) NOT NULL,
    `Expiration` date NULL,
    `Type` nvarchar(250) NOT NULL,
    `Created` date NOT NULL,
    `ApiResourceId` int NOT NULL,
    CONSTRAINT `PK_ApiResourceSecrets` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_ApiResourceSecrets_ApiResources_ApiResourceId` FOREIGN KEY (`ApiResourceId`) REFERENCES `ApiResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_ApiResourceSecrets_ApiResourceId` ON `ApiResourceSecrets` (`ApiResourceId`);



-- IdentityResourceClaims

CREATE TABLE `IdentityResourceClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Type` nvarchar(200) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceClaims` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceClaims_IdentityResources_IdentityResourceId` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceClaims_IdentityResourceId` ON `IdentityResourceClaims` (`IdentityResourceId`);



-- IdentityResourceProperties

CREATE TABLE `IdentityResourceProperties` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Key` nvarchar(250) NOT NULL,
    `Value` nvarchar(2000) NOT NULL,
    `IdentityResourceId` int NOT NULL,
    CONSTRAINT `PK_IdentityResourceProperties` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_IdentityResourceProperties_IdentityResources_IdentityResource` FOREIGN KEY (`IdentityResourceId`) REFERENCES `IdentityResources` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_IdentityResourceProperties_IdentityResourceId` ON `IdentityResourceProperties` (`IdentityResourceId`);



-- Migrate Existing Data

-- ApiClaims -> ApiResourceClaims

INSERT INTO `ApiResourceClaims`
 (`Id`, `Type`, `ApiResourceId`)
SELECT 
 `Id`, `Type`, `ApiResourceId`
FROM `ApiClaims`;



-- ApiProperties -> ApiResourceProperties

INSERT INTO `ApiResourceProperties`
 (`Id`, `Key`, `Value`, `ApiResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `ApiResourceId`
FROM `ApiProperties`;



-- ApiSecrets -> ApiResourceSecrets

INSERT INTO `ApiResourceSecrets`
 (`Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`)
SELECT 
 `Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`
FROM `ApiSecrets`;



-- IdentityClaims -> IdentityResourceClaims

INSERT INTO `IdentityResourceClaims`
 (`Id`, `Type`, `IdentityResourceId`)
SELECT 
 `Id`, `Type`, `IdentityResourceId`
FROM `IdentityClaims`;



-- IdentityProperties -> IdentityResourceProperties

INSERT INTO `IdentityResourceProperties`
 (`Id`, `Key`, `Value`, `IdentityResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `IdentityResourceId`
FROM `IdentityProperties`;


-- ApiScopes -> ApiResourceScopes
INSERT INTO `ApiResourceScopes` 
 (`Id`, `Scope`, `ApiResourceId`)
SELECT 
 `Id`, `Name`, `ApiResourceId`
FROM `ApiScopes`;


-- Alter Existing Tables
SET @OLDSAFEUPDATEVALUE = @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

-- ApiResources	

ALTER TABLE `ApiResources`
	ADD `AllowedAccessTokenSigningAlgorithms` nvarchar (100)
	NULL;
	
ALTER TABLE `ApiResources`
	ADD `ShowInDiscoveryDocument` bit
	NULL;
	
UPDATE `ApiResources` SET `ShowInDiscoveryDocument` = 0;

ALTER TABLE `ApiResources`
	MODIFY `ShowInDiscoveryDocument` bit NOT NULL;
	
	

-- ApiScopeClaims

ALTER TABLE `ApiScopeClaims`
	DROP FOREIGN KEY `FK_ApiScopeClaims_ApiScopes_ApiScopeId`;
	
DROP INDEX `IX_ApiScopeClaims_ApiScopeId`
	ON `ApiScopeClaims`;
		
ALTER TABLE `ApiScopeClaims` CHANGE `ApiScopeId` `ScopeId` int(11);

CREATE INDEX `IX_ApiScopeClaims_ScopeId` ON `ApiScopeClaims` (`ScopeId`);
	
ALTER TABLE `ApiScopeClaims`
	ADD CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ScopeId`
	FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE;
	
	
	
-- ApiScopes

ALTER TABLE `ApiScopes`
	DROP FOREIGN KEY `FK_ApiScopes_ApiResources_ApiResourceId`;
	
DROP INDEX `IX_ApiScopes_ApiResourceId`
	ON `ApiScopes`;
	
ALTER TABLE `ApiScopes`
	ADD `Enabled` bit NULL;

UPDATE `ApiScopes` SET Enabled = 1;

ALTER TABLE `ApiScopes` 
	MODIFY `Enabled` bit NOT NULL;
		
ALTER TABLE `ApiScopes`
	DROP COLUMN `ApiResourceId`;
	

-- Clients

ALTER TABLE `Clients`
	ADD `AllowedIdentityTokenSigningAlgorithms` nvarchar(100) NULL;
	
ALTER TABLE `Clients`
	ADD `RequireRequestObject` bit NULL;
	
UPDATE `Clients` SET `RequireRequestObject` = 0;
	
ALTER TABLE `Clients`
	MODIFY `RequireRequestObject` bit NOT NULL;
	
SET SQL_SAFE_UPDATES = @OLDSAFEUPDATEVALUE;
			
-- Delete Old Tables

-- DROP TABLE `ApiClaims`;
-- DROP TABLE `ApiProperties`;
-- DROP TABLE `ApiSecrets`;
-- DROP TABLE `IdentityClaims`;
-- DROP TABLE `IdentityProperties`;

COMMIT;