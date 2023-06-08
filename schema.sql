/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

-- query multiple tables branch
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(75),
  age INT
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

ALTER TABLE animals
DROP COLUMN species ;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;


ALTER TABLE animals
    ADD COLUMN species_id INTEGER,
    ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species(id)
    ON DELETE CASCADE;



ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id) ON DELETE CASCADE;
