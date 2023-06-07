/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg  BETWEEN 10.4 AND 17.3;

BEGIN; 

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_first_savepoint;

UPDATE animals 
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_first_savepoint;

UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT count(*) AS no_of_animals
FROM animals;

SELECT count(*) AS never_escape
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
GROUP BY neutered
ORDER BY 2 DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS minimum_weight, MAX(weight_kg) AS maximum_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) average_escape__attempts
FROM animals                                              
WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31'
GROUP BY species;

