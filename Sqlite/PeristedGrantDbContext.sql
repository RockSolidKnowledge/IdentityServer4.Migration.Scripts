BEGIN TRANSACTION;

-- Alter Existing Tables

-- DeviceCodes

ALTER TABLE "DeviceCodes" ADD "SessionId" TEXT NULL;
ALTER TABLE "DeviceCodes" ADD "Description" TEXT NULL;

-- PersistedGrants

ALTER TABLE "PersistedGrants" ADD "SessionId" TEXT NULL;
ALTER TABLE "PersistedGrants" ADD "Description" TEXT NULL;
ALTER TABLE "PersistedGrants" ADD "ConsumedTime" TEXT NULL;

CREATE INDEX "IX_PersistedGrants_SubjectId_SessionId_Type" ON "PersistedGrants" ("SubjectId", "SessionId", "Type");

COMMIT;