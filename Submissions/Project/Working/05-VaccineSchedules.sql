/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
*/
-- Create a procedure to update a vaccine name based on the id
-- the first parameter is the ID for the vaccine to change
-- the second is the new vaccine name
CREATE PROCEDURE UpdateVaccineName(@Vaccine_ID int, @newName varchar(20))
AS
BEGIN
	UPDATE Vaccine SET Name = @newName
	WHERE VaccineID = @Vaccine_ID
END
GO

-- Create a procedure to update a vaccine cycle based on the id
-- the first parameter is the ID for the vaccine to change
-- the second is the new vaccine name
CREATE PROCEDURE UpdateVaccineCycle(@Vaccine_ID int, @newCycle varchar(15))
AS
BEGIN
	UPDATE Vaccine SET Cycle = @newCycle
	WHERE VaccineID = @Vaccine_ID
END
GO

-- Update the the Vaccine Cycle and vaccines for Potomac - Spring and Fall
-- First update Potomac - Fall to be just Potomac
EXEC UpdateVaccineName 7,'Potomac'
-- Correct Flu/Rhino - Fall to just be Flu/Rhino
EXEC UpdateVaccineName 8, 'Flu/Rhino'
-- Update Cycle on Potomac to Semi-Annual
EXEC UpdateVaccineCycle 7, 'Semi-Annual'

SELECT * FROM Vaccine





