START TRANSACTION;

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE `DeviceCodes`
	ADD `SessionId` nvarchar(100) NULL;
	
ALTER TABLE `DeviceCodes`
	ADD `Description` nvarchar(200) NULL;



-- PersistedGrants

ALTER TABLE `PersistedGrants`
	ADD `SessionId` nvarchar(100) NULL;
	
ALTER TABLE `PersistedGrants`
	ADD `Description` nvarchar(200) NULL;
	
ALTER TABLE `PersistedGrants`
	ADD `ConsumedTime` date NULL;

ALTER TABLE `PersistedGrants` ADD INDEX `IX_PersistedGrants_SubjectId_SessionId_Type`  (`SubjectId`, `SessionId`, Type);

COMMIT;