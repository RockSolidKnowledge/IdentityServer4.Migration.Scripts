
BEGIN TRANSACTION

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE DeviceCodes
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE DeviceCodes
	ADD [Description] NVARCHAR (200) NULL



-- PersistedGrants

ALTER TABLE PersistedGrants
	ADD SessionId NVARCHAR (100) NULL
	
ALTER TABLE PersistedGrants
	ADD [Description] NVARCHAR (200) NULL
	
ALTER TABLE PersistedGrants
	ADD ConsumedTime DATETIME2 (7) NULL

CREATE NONCLUSTERED INDEX IX_PersistedGrants_SubjectId_SessionId_Type
    ON PersistedGrants(SubjectId ASC, SessionId ASC, Type ASC);

COMMIT TRANSACTION;