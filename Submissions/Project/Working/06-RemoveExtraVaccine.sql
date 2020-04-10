/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: 	Now that Potomac is set to Semi-Annual
		Remove extra Potomac-Spring vaccine
*/
select * from HorseVaccine where VaccineID = 2 or VaccineID = 7
 ORDER BY HorseID

-- Update the Vaccine #2 to all be #7 and 
-- then we can remove 7 from the Vaccine table since we have Potomac
-- down as Semi-Annual now
UPDATE  HorseVaccine
	SET VaccineID = 7 WHERE VaccineID = 2

-- Now remove this VaccineID from the Vaccine Table
DELETE FROM Vaccine WHERE VaccineID = 2

SELECT * FROM horsevaccine where vaccineid = 7 or vaccineid = 2

