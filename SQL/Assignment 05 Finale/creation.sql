-- Create the database
CREATE DATABASE GameLibraryDB_Maryam;
GO

USE GameLibraryDB_Maryam;
GO

-- Users Table
CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    RegisteredAt DATETIME DEFAULT GETDATE()
);

-- Games Table
CREATE TABLE Games (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100) NOT NULL,
    ReleaseYear INT,
    Platform VARCHAR(50),
    Developer VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    AddedAt DATETIME DEFAULT GETDATE()
);

-- Genres Table
CREATE TABLE Genres (
    ID INT PRIMARY KEY IDENTITY(1,1),
    GenreName VARCHAR(50) NOT NULL
);

-- GameGenres Table (Many-to-Many)
CREATE TABLE GameGenres (
    GameID INT,
    GenreID INT,
    PRIMARY KEY(GameID, GenreID),
    FOREIGN KEY (GameID) REFERENCES Games(ID),
    FOREIGN KEY (GenreID) REFERENCES Genres(ID)
);

-- Ratings Table
CREATE TABLE Ratings (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    GameID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 10),
    Review VARCHAR(255),
    RatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (GameID) REFERENCES Games(ID)
);

-- Favorites Table
CREATE TABLE Favorites (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    GameID INT,
    AddedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (GameID) REFERENCES Games(ID)
);