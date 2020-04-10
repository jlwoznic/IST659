/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Add a vet to an existing clinic and a new vet and clinic
*/
-- Add a Vet from Finger Lakes Equine to the Vet Table
INSERT INTO Vet
	(VetID, FirstName, LastName, LicenseNumber, CellPhone, ClinicID)
	VALUES
	('FLE1', 'Jeff', 'LaPoint', '', '', 'FLE')

-- Add Clinic for Bud Allen
INSERT INTO Clinic
	(ClinicID, ClinicName, WebSiteURL, Phone, StreetAddress, City, StateAbbr, Zip)
	VALUES
		('FVC', 'Family Veterinary Center', 'famvets.com', '4132688387', '99 Main Street', 'Haydenville', 'MA', '01039')

-- Now Add Bud to this practice
INSERT INTO Vet
	(VetID, FirstName, LastName, LicenseNumber, CellPhone, ClinicID)
	VALUES
	('FVC1', 'Bud', 'Allen', '', '4132689311', 'FVC')

-- Add Dental Practice
INSERT INTO Clinic
	(ClinicID, ClinicName, WebSiteURL, Phone, StreetAddress, City, StateAbbr, Zip)
	VALUES
		('WRD', 'Wayne Robinson Dentistry', '', '8607369993', '570 Main Street', 'Glastonbury', 'CT', '06033')
-- Add Wayne to this practice
INSERT INTO Vet
	(VetID, FirstName, LastName, LicenseNumber, CellPhone, ClinicID)
	VALUES
	('WRD1', 'Wayne', 'Robinson', '', '8607639993', 'WRD')

SELECT * FROM Clinic
SELECT * FROM Vet