use warehouse query;
alter warehouse query resume;
use database EXAM;
use schema public;

--1
select title from DimAlbum where cd_year>1;

--2

SELECT tf.name
FROM TRACKFACT tf
JOIN DimAlbum a ON tf.AlbumId = a.AlbumId
WHERE a.prod_year = 2000 OR a.prod_year = 2002;

--3

SELECT DISTINCT tf.name, tf.artistid, composer
FROM TRACKFACT tf
JOIN DimGenre g
WHERE g.name = 'Rock' OR g.name = 'Jazz';

--4

select title from DIMALBUM order by len(title) desc limit 10;

--5

select title from dimalbum order by len(title) desc limit 10;

--6
SELECT artistId,  
       COUNT(*) AS num_music
FROM trackfact
GROUP BY artistid
ORDER BY num_music DESC;

--7

SELECT 
g.name as Genres,
COUNT(*) AS num_genres
FROM trackfact tf
JOIN DIMGENRE g ON tf.GenreId=g.GenreId
GROUP BY Genres
ORDER BY num_genres DESC
LIMIT 1;

--8

SELECT DISTINCT
p.Name AS Playlists,
FROM trackfact tf
JOIN DIMPlaylist p ON tf.PlaylistId=p.PlaylistId
WHERE (milliseconds/60000)>=4;

--9

SELECT 
tf.name AS Morceaux
FROM trackfact tf
JOIN DIMGenre g ON tf.GenreId=g.GenreId
JOIN DimArtist a ON tf.artistid=a.artistid
WHERE country='France' AND g.Name='Rock';

--10

SELECT 
g.name AS Genres,
avg(longueur) AS Longueur_Moyenne
FROM (SELECT name,genreid,len(name) as longueur FROM trackfact) tf
JOIN DIMGENRE g ON tf.GenreId=g.GenreId
GROUP BY Genres;

--11

SELECT DISTINCT
p.Name AS Playlists,
FROM trackfact tf
JOIN DIMPlaylist p ON tf.PlaylistId=p.PlaylistId
JOIN DIMARTIST a ON tf.artistid=a.artistid
WHERE birthyear<1990;

