/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Rename the column for Next Vaccine date to make sense
*/
-- Needed to make this table make more sense so altered the table HorseVaccine to 
-- make the column for the next scheduled Vaccine Date to read NextVaccineDate
EXEC sp_rename 'HorseVaccine.VaccineScheduledDate', 'NextVaccineDate', 'COLUMN'
GO
