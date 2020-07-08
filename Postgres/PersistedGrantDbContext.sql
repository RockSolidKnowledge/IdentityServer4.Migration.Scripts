BEGIN;

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE "DeviceCodes"
	ADD "SessionId" character varying(100) NULL;
	
ALTER TABLE "DeviceCodes"
	ADD "Description" character varying(200) NULL;



-- PersistedGrants

ALTER TABLE "PersistedGrants"
	ADD "SessionId" character varying(100) NULL;
	
ALTER TABLE "PersistedGrants"
	ADD "Description" character varying(200) NULL;
	
ALTER TABLE "PersistedGrants"
	ADD "ConsumedTime" timestamp without time zone NULL;

CREATE INDEX "IX_PersistedGrants_SubjectId_SessionId_Type" ON "PersistedGrants" ("SubjectId", "SessionId", "Type");

COMMIT;