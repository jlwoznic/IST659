/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Answer the Question when is a horse due for a vaccine
*/
-- Create a function that will return the date that a specific
-- vaccine is due for a horse
CREATE FUNCTION WhenDue (@Barn_Name varchar(20), @Vaccine_Name varchar(20))
	RETURNS date AS
	BEGIN
		DECLARE @returnValue as date
		-- Return the date for the vaccine 
		-- Notice we need to get the HorseID for this information
		SELECT @returnValue = Max(NextVaccineDate)
			FROM HorseVaccine
			WHERE HorseVaccine.HorseID = 
					(SELECT Horse.HorseID FROM Horse WHERE Horse.BarnName = @Barn_Name) AND
				HorseVaccine.VaccineID = 
					(SELECT Vaccine.VaccineID FROM Vaccine WHERE Vaccine.Name = @Vaccine_Name)
		RETURN @returnValue
	END
GO

-- Check with Berkeley is due for Potomac
SELECT dbo.WhenDue ('Berkeley', 'Potomac')
SELECT dbo.WhenDue ('Sully', 'Potomac')
