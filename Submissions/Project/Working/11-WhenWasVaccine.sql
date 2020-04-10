/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Answer the question when was the Last Does of Vaccine for Horse
*/
-- Create a function that will return the most recent date that a specific
-- vaccine is for a horse
CREATE FUNCTION WhenWasVaccine (@Barn_Name varchar(20), @Vaccine_Name varchar(20))
	RETURNS date AS
	BEGIN
		DECLARE @returnValue as date
		-- Return the date for the vaccine 
		-- Notice we need to get the HorseID for this information
		SELECT @returnValue = Max(VaccineDate)
			FROM HorseVaccine
			WHERE HorseVaccine.HorseID = 
					(SELECT Horse.HorseID FROM Horse WHERE Horse.BarnName = @Barn_Name) AND
				HorseVaccine.VaccineID = 
					(SELECT Vaccine.VaccineID FROM Vaccine WHERE Vaccine.Name = @Vaccine_Name)
		RETURN @returnValue
	END
GO

-- Check When Sully got his Fecal and when Erin got Flu/Rhino
SELECT dbo.WhenWasVaccine ('Erin', 'Flu/Rhino')
SELECT dbo.WhenWasVaccine ('Sully', 'Fecal')
