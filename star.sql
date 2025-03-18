use warehouse query;
alter warehouse query resume;
use database EXAM;
use schema public;

CREATE TABLE DimArtist (
    ArtistId number primary key,
    name string,
    Birthyear number,
    Country string
); 

CREATE TABLE DimMediaType (
    MediaTypeId number primary key,
    Name string
); 

CREATE TABLE DimPlaylist (
    PlaylistId number primary key,
    Name string
); 

CREATE TABLE DimGenre (
    GenreId number primary key,
    Name string
); 


CREATE TABLE DimAlbum(
    AlbumId number primary key,
    Title string,
    Prod_year number,
    Cd_year number
);

CREATE TABLE TrackFact(
    TrackId number identify(1,1) primary key,
    Name string, 
    MediaTypeId number foreign key references MediaType(MediaTypeID), 
    GenreId number foreign key references Genre(GenreId),
    AlbumId number foreign key references Album(AlbumId),
    PlaylistId number foreign key references Playlist(PlaylistId),
    ArtistId number foreign key references Artist(ArtistId),
    Composer string, 
    Milliseconds number,
    Bytes number,
    UnitPrice number
);

INSERT ALL
INTO TrackFact(Name,Composer,Milliseconds,Bytes,UnitPrice,MediaTypeID,GenreID,AlbumId,PlaylistId,ArtistId)
SELECT  DISTINCT
t.Name,t.Composer,t.Milliseconds,t.Bytes,t.UnitPrice,t.MediaTypeID,t.GenreID,t.AlbumId,a1.ArtistId,p.PlayListId
FROM Track t
JOIN Album a2 ON t.AlbumId = a2.AlbumId
JOIN Artist a1 ON a2.ArtistId = a1.ArtistId #On utilise un JOIN ici car un album ne peut pas exister sans un artiste
LEFT JOIN PlayListTrack pt ON t.TrackId = pt.TrackId
LEFT JOIN PlayList p ON pt.PlayListId = p.PlayListId;# On utilise un LEFT JOIN car il est possible qu'un Track ne soit pas dans une playlist, c'est afin de ne pas l'exclure


INSERT all 
into DimGenre (GenreId,Name)
select *
from Genre;


INSERT all 
into DimPlaylist (PlaylistId,Name)
select  *
from Playlist;

INSERT all 
into DimMediaType (MediaTypeId,Name)
select  *
from MediaType;


INSERT all 
into DimArtist (ArtistId,Name,Birthyear,Country)
select  *
from Artist;


INSERT all 
into DimAlbum(AlbumId,Title,Prod_Year,Cd_year)
select  AlbumId,Title,Prod_Year,Cd_year
from Album;
