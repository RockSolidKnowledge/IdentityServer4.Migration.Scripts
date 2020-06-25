-- Transform Data

--ApiClaims -> ApiResourceClaims
SET IDENTITY_INSERT ApiResourceClaims ON;


INSERT INTO ApiResourceClaims
 (Id, [Type], ApiResourceId)
SELECT 
 Id, [Type], ApiResourceId
FROM ApiClaims


SET IDENTITY_INSERT ApiResourceClaims OFF;


--ApiProperties -> ApiResourceProperties
SET IDENTITY_INSERT ApiResourceProperties ON;  
GO

INSERT INTO ApiResourceProperties
 (Id, [Key], [Value], ApiResourceId)
SELECT 
 Id, [Key], [Value], ApiResourceId
FROM ApiProperties
GO

SET IDENTITY_INSERT ApiResourceProperties OFF;
GO

--ApiSecrets -> ApiResourceSecrets
SET IDENTITY_INSERT ApiResourceSecrets ON;  
GO

INSERT INTO ApiResourceSecrets
 (Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId)
SELECT 
 Id, [Description], [Value], Expiration, [Type], Created, ApiResourceId
FROM ApiSecrets
GO

SET IDENTITY_INSERT ApiResourceSecrets OFF;  
GO


--IdentityClaims -> IdentityResourceClaims
SET IDENTITY_INSERT IdentityResourceClaims ON;  
GO

INSERT INTO IdentityResourceClaims
 (Id, [Type], IdentityResourceId)
SELECT 
 Id, [Type], IdentityResourceId
FROM IdentityClaims
GO

SET IDENTITY_INSERT IdentityResourceClaims OFF;  
GO



--IdentityProperties -> IdentityResourceProperties
SET IDENTITY_INSERT IdentityResourceProperties ON;  
GO

INSERT INTO IdentityResourceProperties
 (Id, [Key], [Value], IdentityResourceId)
SELECT 
 Id, [Key], [Value], IdentityResourceId
FROM IdentityProperties
GO

SET IDENTITY_INSERT IdentityResourceProperties OFF;  
GO