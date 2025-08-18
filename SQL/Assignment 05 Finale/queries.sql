USE GameLibraryDB_Maryam;

-- 1. List all games along with their genres
SELECT * FROM vw_GameDetails;

-- 2. Find games released after a certain year
SELECT Title, ReleaseYear FROM Games WHERE ReleaseYear > 2015;

-- 3. Count how many games are available on each platform
SELECT Platform, COUNT(*) AS GameCount
FROM Games
GROUP BY Platform;

-- 4. Find the average rating for each platform
SELECT g.Platform, AVG(r.Rating) AS AvgRating
FROM Games g
JOIN Ratings r ON g.ID = r.GameID
GROUP BY g.Platform;

-- 5. List all games with more than one genre
SELECT g.Title, COUNT(gg.GenreID) AS GenreCount
FROM Games g
JOIN GameGenres gg ON g.ID = gg.GameID
GROUP BY g.Title
HAVING COUNT(gg.GenreID) > 1;

-- 6. Retrieve all ratings made by a specific user
SELECT u.Username, g.Title, r.Rating, r.Review, r.RatedAt
FROM Ratings r
JOIN Users u ON r.UserID = u.ID
JOIN Games g ON r.GameID = g.ID
WHERE u.Username = 'Maryam';

-- 7. Find users who have rated more than one game
SELECT u.Username, COUNT(*) AS RatingCount
FROM Ratings r
JOIN Users u ON r.UserID = u.ID
GROUP BY u.Username
HAVING COUNT(*) >= 2;

-- 8. Highest rated game per user
SELECT Username, Title, Rating
FROM (
    SELECT u.Username, g.Title, r.Rating,
           ROW_NUMBER() OVER (PARTITION BY u.ID ORDER BY r.Rating DESC) AS rn
    FROM Ratings r
    JOIN Users u ON r.UserID = u.ID
    JOIN Games g ON r.GameID = g.ID
) sub
WHERE rn = 1;

-- 9. List all games with their average rating and number of reviews
SELECT g.Title, AVG(r.Rating) AS AvgRating, COUNT(r.Rating) AS ReviewCount
FROM Games g
LEFT JOIN Ratings r ON g.ID = r.GameID
GROUP BY g.Title
ORDER BY AvgRating DESC;

-- 10. How many favorites each user has
SELECT u.Username, COUNT(f.ID) AS TotalFavorites
FROM Users u
LEFT JOIN Favorites f ON u.ID = f.UserID
GROUP BY u.Username;

-- 11. Most favorited games
SELECT g.Title, COUNT(f.ID) AS FavoriteCount
FROM Favorites f
JOIN Games g ON f.GameID = g.ID
GROUP BY g.Title
ORDER BY FavoriteCount DESC;

-- 12. Retrieve all favorite games added in the last 7 days
SELECT u.Username, g.Title, f.AddedAt
FROM Favorites f
JOIN Users u ON f.UserID = u.ID
JOIN Games g ON f.GameID = g.ID
WHERE f.AddedAt >= DATEADD(DAY, -7, GETDATE());

-- 13. Average rating per genre
SELECT ge.GenreName, AVG(r.Rating) AS AvgRating
FROM Ratings r
JOIN Games g ON r.GameID = g.ID
JOIN GameGenres gg ON g.ID = gg.GameID
JOIN Genres ge ON gg.GenreID = ge.ID
GROUP BY ge.GenreName
ORDER BY AvgRating DESC;

-- 14. Top 3 highest rated games
SELECT TOP 3 g.Title, AVG(r.Rating) AS AvgRating
FROM Games g
JOIN Ratings r ON g.ID = r.GameID
GROUP BY g.Title
ORDER BY AvgRating DESC;

-- 15. List of games with no reviews
SELECT g.Title
FROM Games g
LEFT JOIN Ratings r ON g.ID = r.GameID
WHERE r.Rating IS NULL;

-- 16. Retrieve all games from a specific genre using the view
SELECT * FROM vw_GameDetails
WHERE GenreName = 'RPG';

-- 17. Get all games priced under 20 from the view
SELECT DISTINCT Title, Price, ReleaseYear
FROM vw_GameDetails WHERE Price < 20;

-- 18. Count games in each genre using view
SELECT GenreName, COUNT(*) AS GameCount
FROM vw_GameDetails
GROUP BY GenreName;

-- 19. Show all favorite games using view vw_UserFavorites
SELECT * FROM vw_UserFavorites;

-- 20. Find how many games each user has favorited using the view
SELECT Username, COUNT(*) AS FavoritesCount
FROM vw_UserFavorites
GROUP BY Username;

-- 21. Retrieve all favorites added in the current month
SELECT * FROM vw_UserFavorites
WHERE MONTH(AddedAt) = MONTH(GETDATE()) AND YEAR(AddedAt) = YEAR(GETDATE());

-- 22. List all games out of stock
SELECT Title FROM Games WHERE Stock = 0;

-- 23. Find the highest priced game in the system
SELECT TOP 1 Title, Price FROM Games ORDER BY Price DESC;

-- 24. Count how many games are under each price tier
SELECT
    CASE 
        WHEN Price < 10 THEN 'Under 10'
        WHEN Price BETWEEN 10 AND 30 THEN '10-30'
        WHEN Price > 30 THEN 'Over 30'
    END AS PriceRange,
    COUNT(*) AS GameCount
FROM Games
GROUP BY 
    CASE 
        WHEN Price < 10 THEN 'Under 10'
        WHEN Price BETWEEN 10 AND 30 THEN '10-30'
        WHEN Price > 30 THEN 'Over 30'
    END;

-- 25. Which user rated the most games
SELECT TOP 1 u.Username, COUNT(*) AS TotalRatings
FROM Ratings r
JOIN Users u ON r.UserID = u.ID
GROUP BY u.Username
ORDER BY TotalRatings DESC;

-- 26. List games that are both in stock and rated 9 or more on average
SELECT g.Title, g.Stock, AVG(r.Rating) AS AvgRating
FROM Games g
JOIN Ratings r ON g.ID = r.GameID
GROUP BY g.ID, g.Title, g.Stock
HAVING AVG(r.Rating) >= 9 AND g.Stock > 0;

-- 27. Get game title, genre, and price ordered by genre then price
SELECT DISTINCT gd.Title, gd.GenreName, gd.Price
FROM vw_GameDetails gd
ORDER BY gd.GenreName, gd.Price;

-- 28. List games available on PC and their genres
SELECT * FROM vw_GameDetails WHERE Platform = 'PC';

-- 29. Find games that are both favorited and rated by the same user
SELECT DISTINCT u.Username, g.Title
FROM Ratings r
JOIN Favorites f ON r.GameID = f.GameID AND r.UserID = f.UserID
JOIN Users u ON r.UserID = u.ID
JOIN Games g ON r.GameID = g.ID;

-- 30. All games and their Genres
SELECT g.Title, ge.GenreName
FROM Games g
JOIN GameGenres gg ON g.ID = gg.GameID
JOIN Genres ge ON gg.GenreID = ge.ID
ORDER BY ge.GenreName;

-- 31. Favorite Games of a User
SELECT g.Title AS "User's Favorites"
FROM Favorites f
JOIN Users u ON f.UserID = u.ID
JOIN Games g ON f.GameID = g.ID
WHERE u.Username = 'Maryam';

-- 32. Recently Rated Games
SELECT g.Title, r.Rating, r.RatedAt
FROM Ratings r
JOIN Games g ON r.GameID = g.ID
WHERE r.RatedAt >= DATEADD(DAY, -30, GETDATE()); -- the last 30 days