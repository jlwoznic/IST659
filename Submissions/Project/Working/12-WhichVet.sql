/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Find out Which Vet did the Last Vaccine for Horse
*/
CREATE FUNCTION dbo.WhichVet (@Horse_Name varchar(20), @Vaccine_Name varchar(20))
RETURNS varchar(4)
BEGIN
    -- Declare all the variables
    DECLARE @Horse_ID int
    DECLARE @Last_Vaccine_Date date 
    DECLARE @Vaccine_ID int
    DECLARE @returnValue as varchar(4)

    -- Set some intermediate variables for usage later in function
    SELECT @Vaccine_ID = Vaccine.VaccineID from Vaccine WHERE Vaccine.Name = @Vaccine_Name
    SELECT @Horse_ID = Horse.HorseID FROM Horse WHERE Horse.BarnName = @Horse_Name
    -- Use function WhenWasVaccine to get lastest date
	SELECT @Last_Vaccine_Date = dbo.WhenWasVaccine (@Horse_Name, @Vaccine_Name)

	-- Good to Here
    SELECT @returnValue = HorseVaccine.VetID FROM HorseVaccine
                WHERE HorseVaccine.VaccineDate = @Last_Vaccine_Date AND
                      HorseVaccine.HorseID = @Horse_ID AND
                      HorseVaccine.VaccineID = @Vaccine_ID
	RETURN @returnValue
END
GO

-- Create a View that has each Vet and the clinic where he/she works
CREATE VIEW VetandClinic AS
	SELECT Vet.VetID, Vet.FirstName, Vet.LastName, Clinic.ClinicName FROM Vet
		INNER JOIN Clinic ON Vet.ClinicID = Clinic.ClinicID
GO

-- Use Which Vet in combination with new View
SELECT FirstName, LastName, ClinicName FROM VetandClinic	
	WHERE VetID = (SELECT dbo.WhichVet ('Sully', 'Potomac'))

    