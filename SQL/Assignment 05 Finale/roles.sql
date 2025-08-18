-- Create login & user
CREATE LOGIN GameUser WITH PASSWORD = 'StrongPass';
USE GameLibraryDB_Maryam;
CREATE USER GameUser FOR LOGIN GameUser;

-- Create role
CREATE ROLE ReaderRole;
EXEC sp_addrolemember 'ReaderRole', 'GameUser';

-- Grant permissions
GRANT SELECT ON Games TO ReaderRole;
GRANT SELECT ON Genres TO ReaderRole;
GRANT SELECT ON Ratings TO ReaderRole;