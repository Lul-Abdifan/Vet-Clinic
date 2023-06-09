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

UPDATE animals
SET species = 'unspecified';


SELECT species
FROM animals;

ROLLBACK;

SELECT species
FROM animals;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = ''
;

SELECT species, name
FROM animals;

COMMIT                
;

SELECT species, name
FROM animals;

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


-- query multiple tables branch
SELECT animals.name, owners.full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS animals_of_species_Pokemon
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT owners.full_name,animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
;

SELECT COUNT(*) AS animals_species_no,species.name
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;


SELECT animals.name,species.name,owners.full_name from animals
JOIN owners ON animals.owner_id = owners.id
join species ON animals.species_id = species.id
where species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


SELECT animals.name from animals
JOIN owners ON animals.owner_id 
= (SELECT id from owners where owners.full_name = 'Dean Winchester')
where animals.escape_attempts = 0;


SELECT COUNT(*) AS the_max_owner ,owners.full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC 
LIMIT 1;


SELECT animals.name from animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
where vets.name = 'William Tatcher'
order by visits.date_of_visit DESC
limit 1;

SELECT COUNT(animals.name) AS animal_count
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT animals.name, COUNT(*) AS max_visits
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
GROUP BY animals.name
ORDER BY max_visits DESC
LIMIT 1;



SELECT animals.name, visits.date_of_visit
FROM visits 
JOIN vets 
ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit
LIMIT 1;


SELECT animals.name AS animal_name, animals.date_of_birth as animal_birth, vets.name AS Doctor, date_of_graduation as Doctor_graduation, visits.date_of_visit as Doctor_visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT max_visited
FROM (SELECT COUNT(*) as max_animal, species.name as max_visited
FROM vets 
JOIN
visits ON visits.vet_id = vets.id
JOIN
animals ON animals.id = visits.animal_id
JOIN 
species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY max_animal DESC
LIMIT 1) as most_visits;


































