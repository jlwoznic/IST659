/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Total Spent on Vaccines for a specific horse in a given year
*/
CREATE FUNCTION dbo.TotalPerHorsePerYear (@Horse_Name varchar(20), @Year varchar(4))
RETURNS decimal(6,2)
BEGIN
    -- Declare all the variables
    DECLARE @Horse_ID int
    DECLARE @Total_Price decimal(6,2)

    -- Set some intermediate variables for usage later in function
    SELECT @Horse_ID = Horse.HorseID from Horse WHERE Horse.BarnName = @Horse_Name

	-- Good to Here
    SELECT @Total_Price = SUM(HorseVaccine.VaccineCost) FROM HorseVaccine
                WHERE HorseVaccine.HorseID = @Horse_ID AND
					  DATEPART(yyyy,HorseVaccine.VaccineDate) = @Year
	RETURN @Total_Price
END
GO


SELECT dbo.TotalPerHorsePerYear('Batman', '2018')

