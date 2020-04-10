/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: How much on vaccines, dentist and chiro for a specific year
*/
CREATE FUNCTION dbo.HowMuchforYear (@Year varchar(4))
RETURNS decimal(10,2)
BEGIN
    -- Declare all the variables
    DECLARE @Total_Cost decimal(10,2)

	-- Go get em
	SELECT @Total_Cost = SUM(VaccineCost)
	FROM  HorseVaccine
		WHERE DATEPART(yyyy,VaccineDate) = @Year
	RETURN @Total_Cost
END
GO

SELECT dbo.HowMuchForYear('2017')