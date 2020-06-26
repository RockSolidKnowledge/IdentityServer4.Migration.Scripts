-- Transform Data

--ApiClaims -> ApiResourceClaims

INSERT INTO `ApiResourceClaims`
 (`Id`, `Type`, `ApiResourceId`)
SELECT 
 `Id`, `Type`, `ApiResourceId`
FROM `ApiClaims`



--ApiProperties -> ApiResourceProperties

INSERT INTO `ApiResourceProperties`
 (`Id`, `Key`, `Value`, `ApiResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `ApiResourceId`
FROM `ApiProperties`



--ApiSecrets -> ApiResourceSecrets

INSERT INTO `ApiResourceSecrets`
 (`Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`)
SELECT 
 `Id`, `Description`, `Value`, `Expiration`, `Type`, `Created`, `ApiResourceId`
FROM `ApiSecrets`



--IdentityClaims -> IdentityResourceClaims

INSERT INTO `IdentityResourceClaims`
 (`Id`, `Type`, `IdentityResourceId`)
SELECT 
 `Id`, `Type`, `IdentityResourceId`
FROM `IdentityClaims`



--IdentityProperties -> IdentityResourceProperties

INSERT INTO `IdentityResourceProperties`
 (`Id`, `Key`, `Value`, `IdentityResourceId`)
SELECT 
 `Id`, `Key`, `Value`, `IdentityResourceId`
FROM `IdentityProperties`