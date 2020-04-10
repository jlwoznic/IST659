/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Average Price for a specific vaccine
*/
CREATE FUNCTION dbo.AveragePrice (@Vaccine_Name varchar(20))
RETURNS decimal(6,2)
BEGIN
    -- Declare all the variables
    DECLARE @Vaccine_ID int
    DECLARE @Average_Price decimal(6,2)

    -- Set some intermediate variables for usage later in function
    SELECT @Vaccine_ID = Vaccine.VaccineID from Vaccine WHERE Vaccine.Name = @Vaccine_Name

	-- Good to Here
    SELECT @Average_Price = AVG(VaccineCost) FROM HorseVaccine
                WHERE HorseVaccine.VaccineID = @Vaccine_ID
	RETURN @Average_Price
END
GO


SELECT dbo.AveragePrice('Potomac')