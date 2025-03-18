use warehouse query;
alter warehouse query resume;
create database EXAM;
use schema public;

CREATE STAGE music_s3_stage
URL='s3://course-snowflakes/sample/music/'
 credentials = (aws_key_id='AKIASAGY5RWHA6O5USH6',
                aws_secret_key='8j6YXKG1uqDHYayN7GFlcCHfbtNeEpjJ+BDtAXEW');

create table Artist (
    ArtistId number primary key,
    name string,
    Birthyear number,
    Country string
); 

create table MediaType (
    MediaTypeId number primary key,
    Name string
); 

create table Playlist (
    PlaylistId number primary key,
    Name string
); 

create table Genre (
    GenreId number primary key,
    Name string
); 


create table Album(
    AlbumId number primary key,
    Title string,
    ArtistId number foreign key references Artist(ArtistId),
    Prod_year number,
    Cd_year number
);

create table Track(
    TrackId number primary key,
    Name string, 
    MediaTypeId number foreign key references MediaType(MediaTypeID), 
    GenreId number foreign key references Genre(GenreId),
    AlbumId number foreign key references Album(AlbumId),
    Composer string, 
    Milliseconds number,
    Bytes number,
    UnitPrice number
); 
create table PlaylistTrack(
    PlaylistId number foreign key references Playlist(PlaylistId),
    TrackId number foreign key references Track(TrackId),
    primary key(PlaylistId,TrackId)
);


CREATE FILE FORMAT CLASSIC_CSV;
ALTER FILE FORMAT "DEMO"."PUBLIC".CLASSIC_CSV 
SET COMPRESSION = 'AUTO' 
RECORD_DELIMITER = '\n'
FIELD_DELIMITER = ',' 
SKIP_HEADER = 1 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO'
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE'
TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
NULL_IF = ('NULL','','\\N');


use warehouse load;
alter warehouse load resume;

copy into Artist
from @music_s3_stage/Artist.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into MEDIATYPE
from @music_s3_stage/MediaType.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into Genre
from @music_s3_stage/Genre.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into Playlist
from @music_s3_stage/Playlist.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into Album
from @music_s3_stage/Album.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into Track
from @music_s3_stage/Track.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";

copy into PlaylistTrack
from @music_s3_stage/PlaylistTrack.csv
file_format = classic_csv
ON_ERROR = "CONTINUE";
