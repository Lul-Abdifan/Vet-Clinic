-- CREATE DATABASE clinic;
CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  date_of_birth DATE
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_histories_id INT,
  FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id) 
);


CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR
);


CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) 
);


CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR,
  name VARCHAR
);


CREATE TABLE link_treatment_and_medical_histories (
  history_id INT,
  treatments_id INT,
  FOREIGN KEY (history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatments_id) REFERENCES treatments(id) 
);

-- foreign key indexes
CREATE INDEX patients_index ON medical_histories(patient_id);

CREATE INDEX invoices_index ON invoice_items(invoice_id);

CREATE INDEX medical_histories_index ON invoices(medical_histories_id);

CREATE INDEX treatments_index ON invoice_items(treatment_id);

CREATE INDEX history_index ON treatment_medical_histories(history_id);

CREATE INDEX treatment_index ON treatment_medical_histories(treatments_id);