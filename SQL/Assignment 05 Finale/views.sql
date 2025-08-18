USE GameLibraryDB_Maryam;

-- View: Game Details with Genre
CREATE VIEW vw_GameDetails AS
SELECT g.ID, g.Title, g.ReleaseYear, g.Platform, g.Developer, g.Price, ge.GenreName
FROM Games g
JOIN GameGenres gg ON g.ID = gg.GameID
JOIN Genres ge ON gg.GenreID = ge.ID;
GO

-- View: User Favorites
CREATE VIEW vw_UserFavorites AS
SELECT u.Username, g.Title, f.AddedAt
FROM Favorites f
JOIN Users u ON f.UserID = u.ID
JOIN Games g ON f.GameID = g.ID;
GO

SELECT * FROM vw_GameDetails;
GO

SELECT * FROM vw_UserFavorites;
GO