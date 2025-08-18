USE GameLibraryDB_Maryam;

-- Genres
INSERT INTO Genres (GenreName) VALUES 
('Action'), ('RPG'), ('Puzzle'), 
('Shooter'), ('Strategy'), ('Turn-Based'),
('Visual Novel'), ('Simulation'), ('Point & Click'),
('Sports'), ('Fighting'), ('Survival'),
('Adventure'), ('Horror'), ('Platformer'),
('Story Focused'), ('Indie');

-- Users
INSERT INTO Users (Username, Email, Country) VALUES
('Maryam', 'maryam@gmail.com', 'Egypt'),
('PixelPro', 'pixel@gmail.com', 'USA');

-- Games
INSERT INTO Games (Title, ReleaseYear, Platform, Developer, Price, Stock) VALUES
('The Witcher 3', 2015, 'PC', 'CD Projekt', 39.99, 100),
('Portal 2', 2011, 'PC', 'Valve', 9.99, 50),
('Clair Obscur: Expedition 33', 2025, 'PC', 'Sandfall Interactive', 59.99, 50),
('Celeste', 2018, 'PC', 'Maddy Makes Games Inc.', 10.49, 50),
('Mouthwashing', 2024, 'PC', 'Wrong Organ', 7.29, 50),
('Undertale', 2015, 'PC', 'tobyfox', 9.99, 50),
('Dad of War', 2018, 'PS4', 'Santa Monica Studio', 29.99, 20);

-- GameGenres
INSERT INTO GameGenres (GameID, GenreID) VALUES
(1, 2),  -- Witcher: RPG
(2, 3),  -- Portal 2: Puzzle
(3, 2),  -- Clair Obscur: Expedition 33: RPG
(3, 6),  -- Clair Obscur: Expedition 33: Turn-Based
(3, 5),  -- Clair Obscur: Expedition 33: Strategy
(3, 13), -- Clair Obscur: Expedition 33: Adventure
(4, 13), -- Celeste: Adventure
(4, 15), -- Celeste: Platformer
(4, 17), -- Celeste: Indie
(5, 13), -- Mouthwashing: Adventure
(5, 16), -- Mouthwashing: Story Focused
(5, 17), -- Mouthwashing: Indie
(6, 2),  -- Undertale: RPG
(6, 6),  -- Undertale: Turn-Based
(6, 5),  -- Undertale: Strategy
(6, 13), -- Undertale: Adventure
(6, 17), -- Undertale: Indie
(7, 1);  -- Dad of War: Action

-- Ratings
INSERT INTO Ratings (UserID, GameID, Rating, Review) VALUES
(2, 1, 10, 'Amazing story!'),
(1, 3, 10, 'So Beautiful! Amazing graphics & killer story'),
(1, 5, 8, 'Story is soo deep with a great twist'),
(1, 6, 8, 'Silly but catching story with heavy decision weights'),
(2, 2, 9, 'Clever puzzles');

-- Favorites
INSERT INTO Favorites (UserID, GameID) VALUES 
(1, 3), (1, 5), (1, 6), 
(2, 1), (2, 2), (2, 3);


-- more because the data was not enough :(
INSERT INTO Users (Username, Email, Country) VALUES 
('GamerX', 'gamerx@gmail.com', 'Germany'),
('ShadowFox', 'shadowfox@gmail.com', 'UK'),
('LunaPlayer', 'luna@gmail.com', 'Canada'),
('KnightRider', 'knight@gmail.com', 'Japan'),
('ArcadeQueen', 'arcadeq@gmail.com', 'France');

INSERT INTO Games (Title, ReleaseYear, Platform, Developer, Price, Stock) VALUES 
('Hollow Knight', 2017, 'PC', 'Team Cherry', 14.99, 75),
('Stardew Valley', 2016, 'PC', 'ConcernedApe', 14.99, 80),
('Resident Evil 4', 2023, 'PC', 'Capcom', 59.99, 60),
('Cuphead', 2017, 'PC', 'StudioMDHR', 19.99, 50),
('Dark Souls III', 2016, 'PC', 'FromSoftware', 39.99, 0);

-- Hollow Knight: Platformer, Adventure, Indie
INSERT INTO GameGenres (GameID, GenreID) VALUES (8, 13), (8, 15), (8, 17);

-- Stardew Valley: Simulation, Story Focused, Indie
INSERT INTO GameGenres (GameID, GenreID) VALUES (9, 8), (9, 16), (9, 17);

-- Resident Evil 4: Horror, Shooter, Survival
INSERT INTO GameGenres (GameID, GenreID) VALUES (10, 14), (10, 4), (10, 12);

-- Cuphead: Platformer, Action, Indie
INSERT INTO GameGenres (GameID, GenreID) VALUES (11, 15), (11, 1), (11, 17);

-- Dark Souls III: RPG, Action, Adventure
INSERT INTO GameGenres (GameID, GenreID) VALUES (12, 2), (12, 1), (12, 13);

INSERT INTO Ratings (UserID, GameID, Rating, Review) VALUES
(3, 8, 10, 'A beautiful journey with tight controls!'),
(4, 9, 9, 'Relaxing and addictive farming sim.'),
(5, 10, 8, 'Great horror remake, intense gameplay.'),
(6, 11, 9, 'Hard but fair, unique art style!'),
(7, 12, 10, 'Dark atmosphere and incredible challenge.');

INSERT INTO Favorites (UserID, GameID) VALUES 
(3, 8), (3, 9),
(4, 10),
(5, 10), (5, 11),
(6, 11), (6, 12),
(7, 12);
