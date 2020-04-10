/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
	Task: 	Update the Microchip for a horse given it's barn name and
		new chip number
*/
-- Create a procedure to update a the microchip value in the Horse table
-- on a horse to reflect the microchip added
CREATE PROCEDURE UpdateMicrochip(@Barn_Name varchar(20), @New_MicroChip varchar(30))
	AS
	BEGIN
		UPDATE Horse SET Horse.Microchip = @New_Microchip WHERE BarnName = @Barn_Name
END
GO

EXEC UpdateMicrochip 'Erin', '981020025770532'
EXEC UpdateMicrochip 'Chicago', '981020025740370'
EXEC UpdateMicrochip 'Sully', '985120028870001'
GO

SELECT * FROM Horse