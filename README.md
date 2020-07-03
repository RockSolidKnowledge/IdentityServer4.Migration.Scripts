#What the MigrationDbContext script aims to achieve

##Alter Existing Tables

###DeviceCodes
SessionId and Descriptions columns are added with NULL values

###PersistedGrants
SessionId, Description and ConsumedTime columns are added, all with null values. An index is added using SubjectId, SessionId and Type.

#What the ConfigurationDbContext script aims to achieve

##Add New Tables
Two new additional tables are added for IdentityServer4 V4:
•	ApiResourceScopes
•	ApiScopeProperties

##Replace Existing Tables
For MSSQL, PostgreSQL and MySQL, the are five tables added that serve the purpose of replacing tables that have changed name:
•	ApiResourceClaims to replace ApiClaims
•	ApiResourceProperties to replace ApiProperties
•	ApiResourceSecrets to replace ApiSecrets
•	IdentityResourceClaims to replace IdentityClaims
•	IdentityResourceProperties to place IdentityProperties

For SQLite there are nine tables that are added which are used as replacement tables for renamed tables (including their indexes and keys) and tables with changed column names. These are all of the above as well as the additional columns:
•	ApiResourcesTemp to be renamed to ApiResources later
•	ApiScopeClaimsTemp to be renamed to ApiScopeClaims later
•	ApiScopesTemp to be renamed to ApiScopes later
•	ClientsTemp to be renamed to Clients later

##Migrate Data
Data from tables that are changing name or can otherwise not be altered (as is the case with SQLite) are migrated over to the new tables mentioned above. ApiResourceScopes will be populated with data from the ApiScopes table for compatibility reasons.

*A note on SQLite*
The temporary tables created for replacement will have values inserted for existing records. See section below for the column names and their associated initial values.

##Alter Existing Tables
For MSSQL, MySQL and PostgreSQL some of the existing tables are modified and in some cases new columns are provided with values if they are non-nullable.

###ApiResources
Two columns are added to ApiResources, AllowedAccessTokenSigningAlgorithms and ShowInDiscoveryDocument. Any existing records will have a null value for AllowedAccessTokenSigningAlgorithms and a 0/FALSE for ShowInDiscoveryDocument.

###ApiScopeClaims
The ApiScopeId column on ApiResources has been changed to ScopeId, this means the constraints and indexes associated with this column are dropped, a rename occurs and then the constraints and indexes are added again.

###ApiScopes
The ApiResourceId columns is dropped from ApiScopes along with its foreign key constraint and index. The Enabled column is added and any existing records will be given a value of 1/TRUE.

###Clients
AllowedIdentityTokenSigningAlgorithms and RequireRequestObject columns are added and existing records will have a NULL value and a 0/FALSE value respectively.

##Drop Tables
The final section of the script has commented out DROP TABLE statements. Please uncomment and run them when you feel comfortable that all of the existing data has been migrated properly.

