/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: 	This sets the NextVaccineDate to be the proper date
			based on the cycle in the Vaccine table
*/
-- Create a procedure to update a vaccine cycle based on the id
-- the first parameter is the ID for the vaccine to change
-- the second is the new vaccine name
CREATE PROCEDURE UpdateNextDate(@Vaccine_ID int)
AS
BEGIN
	-- DECLARE variables we will using
	DECLARE @Add_Months as int

	-- Get the cycle and convert that to number of months to add to date
	-- Use NumMonths function
   	SET @Add_Months = (SELECT dbo.NumMonths (@Vaccine_ID))

	-- Update the HorseVaccine Table with the proper NextVaccineDate 
	-- (adding proper number of months from previous date)
	UPDATE HorseVaccine SET HorseVaccine.NextVaccineDate = DATEADD(mm, @Add_Months, VaccineDate)
		WHERE VaccineID = @Vaccine_ID
END
GO

-- Need to run this for each vaccine 1 through 10, except 2 which we removed
DECLARE @Vaccine_ID int
SET @Vaccine_ID = 1
WHILE (@Vaccine_ID <= 10)
	BEGIN
		EXEC UpdateNextDate @Vaccine_ID
		SET @Vaccine_ID = @Vaccine_ID + 1
	END
GO

SELECT * FROM HorseVaccine ORDER BY VaccineID, HorseID