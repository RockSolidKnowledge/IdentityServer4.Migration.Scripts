
-- Alter tables

-- ApiResources	

ALTER TABLE `ApiResources`
	ADD `AllowedAccessTokenSigningAlgorithms` nvarchar (100)
	NULL
	
ALTER TABLE `ApiResources`
	ADD `ShowInDiscoveryDocument` bit
	NULL
	
UPDATE `ApiResources` SET `ShowInDiscoveryDocument` = 0

ALTER TABLE `ApiResources`
	ALTER COLUMN `ShowInDiscoveryDocument` bit NOT NULL
	
	

-- ApiScopeClaims

ALTER TABLE `ApiScopeClaims`
	DROP CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ApiScopeId`
	
DROP INDEX `IX_ApiScopeClaims_ApiScopeId`
	ON `ApiScopeClaims`
		
ALTER TABLE `ApiScopeClaims` RENAME `ApiScopeId` TO `ScopeId`

CREATE INDEX `IX_ApiScopeClaims_ScopeId` ON `ApiScopeClaims` (`ScopeId`);
	
ALTER TABLE `ApiScopeClaims`
	ADD CONSTRAINT `FK_ApiScopeClaims_ApiScopes_ScopeId`
	FOREIGN KEY (`ScopeId`) REFERENCES `ApiScopes` (`Id`) ON DELETE CASCADE
	
	
	
-- ApiScopes

ALTER TABLE `ApiScopes`
	DROP CONSTRAINT `FK_ApiScopes_ApiResources_ApiResourceId`
	
DROP INDEX `IX_ApiScopes_ApiResourceId`
	ON `ApiScopes`
	
ALTER TABLE `ApiScopes`
	ADD `Enabled` bit NULL

UPDATE `ApiScopes` SET Enabled = 1

ALTER TABLE `ApiResources` 
	ALTER COLUMN `Enabled` bit NOT NULL
		
	

-- Clients

ALTER TABLE `Clients`
	ADD `AllowedIdentityTokenSigningAlgorithms` nvarchar(100) NULL
	
ALTER TABLE `Clients`
	ADD `RequireRequestObject` bit NULL
	
UPDATE `Clients` SET `RequireRequestObject` = 0
	
ALTER TABLE `Clients`
	ALTER COLUMN `RequireRequestObject` bit NOT NULL
	
	

-- DeviceCodes

ALTER TABLE `DeviceCodes`
	ADD `SessionId` nvarchar(100) NULL
	
ALTER TABLE `DeviceCodes`
	ADD `Description` nvarchar(200) NULL



-- PersistedGrants

ALTER TABLE `PersistedGrants`
	ADD `SessionId` nvarchar(100) NULL
	
ALTER TABLE `PersistedGrants`
	ADD `Description` nvarchar(200) NULL
	
ALTER TABLE `PersistedGrants`
	ADD `ConsumedTime` datetime2(7) NULL

ALTER TABLE `PersistedGrants` ADD INDEX `IX_PersistedGrants_SubjectId_SessionId_Type`  (`SubjectId`, `SessionId`, Type)