/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Make both VaccineName (Vaccine.Name) in the Vaccine table and
	      BarnName in the Horse table unique constraints
*/

ALTER TABLE Horse
ADD CONSTRAINT UK_BarnName UNIQUE(BarnName)

ALTER TABLE Vaccine
ADD CONSTRAINT UK_VaccineName UNIQUE(Name)
