
-- Add ApiResourceScopes

CREATE TABLE "ApiResourceScopes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResourceScopes" PRIMARY KEY AUTOINCREMENT,
    "Scope" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiResourceScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiResourceScopes_ApiResourceId" ON "ApiResourceScopes" ("ApiResourceId");

-- Add ApiScopeProperties

CREATE TABLE "ApiScopeProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopeProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ScopeId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopeProperties_ApiScopes_ScopeId" FOREIGN KEY ("ScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiScopeProperties_ScopeId" ON "ApiScopeProperties" ("ScopeId");