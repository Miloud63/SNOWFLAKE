Ce projet consiste en la mise en œuvre d’une Data Warehouse avec Snowflake, afin de stocker et faire des requêtes sur des données musicales (albums, artistes, morceaux, genres, etc.).
Nous avons divers scripts dans ce projet :
init.sql (script de création des tables brutes),
star.sql (script de création du schéma en étoile), qui permet d’effectuer une dénormalisation rendant les requêtes SQL via Snowflake plus simples (tables de faits et tables de dimensions),
query.sql (qui exécute les requêtes via Snowflake à l’aide d’un warehouse spécifique afin de répondre à diverses problématiques).
Et enfin, le fichier answer.txt, qui stocke les différentes réponses résultant des requêtes que nous avons effectuées plus tôt avec query.sql, sur le schéma en étoile (défini dans star.sql).
