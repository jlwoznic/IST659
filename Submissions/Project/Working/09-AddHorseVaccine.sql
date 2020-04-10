/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: Provide a Procedure to Add a Vaccination Record for a horse
*/
-- Create a procedure that can be called over and over 
-- the second is the new vaccine name
CREATE PROCEDURE AddHorseVaccine (@Barn_Name as varchar(20), @Vaccine_Name varchar(20), 
			@Batch_Name as varchar(20), @Vaccine_Date date, @First_Name varchar(20), @Last_Name varchar(20),  
			@V_Cost decimal(6,2))
	AS
	BEGIN
	-- Will need to do some investigation into other tables to get the following:
	-- Get Microchip from @Barn_Name from Horse table
	-- Get VaccineID from Vaccine Table from @Vaccine_Name
	-- Use NumMonths Function to update the value for VaccineScheduledDate
	DECLARE @Vaccine_ID int
	DECLARE @Horse_ID int
	DECLARE @Add_Months int
	DECLARE @Vet_ID varchar(4)

	SET @Vaccine_ID = (SELECT Vaccine.VaccineID FROM Vaccine WHERE Vaccine.Name = @Vaccine_Name)
	SET @Add_Months = (SELECT dbo.NumMonths (@Vaccine_ID))
	SET @Horse_ID = (SELECT Horse.HorseID FROM Horse WHERE Horse.BarnName = @Barn_Name)
	SET @Vet_ID = (SELECT Vet.VetID FROM Vet WHERE Vet.FirstName = @First_Name AND Vet.LastName = @Last_Name)
	
	INSERT INTO HorseVaccine
		(HorseID, VaccineID, VaccineBatch, VaccineDate, NextVaccineDate, VaccineCost, VetID)
		VALUES
		(@Horse_ID, @Vaccine_ID, @Batch_Name, @Vaccine_Date, 
			DATEADD(mm, @Add_Months, @Vaccine_Date), @V_Cost, @Vet_ID)
END
GO

-- Add Sully's Vaccines from 11/26/2018
EXEC AddHorseVaccine 'Sully', 'Potomac', '', '11/26/2018', 'Mike', 'Reilly' , 42.00
EXEC AddHorseVaccine 'Sully', 'Flu/Rhino', '', '11/26/2018', 'Mike', 'Reilly' , 56.00
EXEC AddHorseVaccine 'Sully', 'Fecal', '', '11/26/2018', 'Mike', 'Reilly', 38.00
EXEC AddHorseVaccine 'Sully', 'Lyme Titer', '', '11/26/2018', 'Mike', 'Reilly', 81.00  
EXEC AddHorseVaccine 'Sully', 'Dentist', '', '11/19/2018', 'Wayne', 'Robinson', 85.00  
EXEC AddHorseVaccine 'Sully', 'Chiro', '', '11/29/2018', 'Bud', 'Allen', 195.00  
GO
-- Need to repeat for Erin and Chicago



SELECT * FROM HorseVaccine WHERE HorseID = 6
SELECT * from HorseVaccine WHERE Microchip = '6' AND VaccineID = 6