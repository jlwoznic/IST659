-- Create ?? to return which Vet Name did the last Vaccine for Horse
-- Need to return:
--      Vet.FirstName, Vet.LastName, Clinic.Name

CREATE FUNCTION dbo.WhichVet (@Horse_Name varchar(20), @Vaccine_Name varchar(20))
RETURNS varchar(87)
BEGIN
    -- Declare all the variables
    DECLARE @Clinic_Name varchar(40)
    DECLARE @Clinic_ID int
    DECLARE @Vet_ID int
    DECLARE @Horse_ID int
    DECLARE @Last_Vaccine_Date date 
    DECLARE @Vaccine_ID int
    DECLARE @Vet_First varchar(20)
    DECLARE @Vet_Last varchar(20)
    DECLARE @returnValue as varchar(87)

    -- Set some intermediate variables for usage later in function
    SELECT @Vaccine_ID = SELECT Vaccine.VaccineID from Vaccine WHERE Vaccine.Name = @Vaccine_Name
    SELECT @Horse_ID = SELECT Horse.HorseID FROM Horse WHERE Horse.BarnName = @Horse_Name
    SELECT @Last_Vaccine_Date = SELECT Max(VaccineDate) FROM HorseVaccine 
                WHERE HorseVaccine.HorseID = @Horse_ID
    SELECT @Vet_ID = SELECT HorseVaccine.VetID FROM HorseVaccine
                WHERE HorseVaccine.VaccineDate = @Last_Vaccine_Date AND
                      HorseVaccine.HorseID = @Horse_ID AND
                      HorseVaccine.VaccineID = @Vaccine_ID
    SELECT @Vet_First = SELECT Vet.FirstName FROM Vet WHERE Vet.VetID = @Vet_ID
    SELECT @Vet_Last = SELECT Vet.LastName FROM Vet WHERE Vet.VetID = @Vet_ID
        SELECT @Clinic_ID = SELECT Vet.ClinicID FROM Vet WHERE Vet.VetID = @Vet_ID
    --SELECT @Clinic_Name = SELECT Clinic.ClinicName from Clinic WHERE Clinic.ClinicID = @Clinic_ID
    SELECT Clinic.Clinic_Name AS @Clinic_Name FROM Clinic WHERE Clinic.ClinicID = @Clinic_ID
    SELECT @returnValue = CONCAT(@Vet_First, ' ', @Vet_Name, ' from ', @Clinic_Name)

    RETURN @returnValue
END
GO

-- Create a view to retrieve the top 10 vc_Users and their 
-- VidCast counts
CREATE VIEW vc_MostProlificUsers AS
	SELECT TOP 10
		*,
		dbo.vc_VidCastCount(vc_UserID) as VidCastCount
	FROM vc_User
	ORDER BY VidCastCount DESC
GO

-- Select all from this new view
SELECT * from vc_MostProlificUsers


CREATE FUNCTION dbo.vc_VidCastDuration(@User_ID int)
-- SUM() is an integer value, so return it as an int
RETURNS int AS 
BEGIN
	DECLARE @returnValue int -- matches the function's return type
	/*
		Get the sum of the vidcast actual durations for the
		provided @User_ID tag and assign that value to @returnValue. 
		Note that we use the @User_ID parameter in the WHERE clause
		limit our sum to those VidCast associated with @User_ID
		that was passed to the function.
	*/
	SELECT @returnValue = SUM(DATEDIFF(n, StartDateTIme, EndDateTime)) 
		FROM vc_VidCast
	INNER JOIN vc_User ON vc_VidCast.vc_UserID = vc_User.vc_UserID
	INNER JOIN vc_Status on vc_VidCast.vc_StatusID = (SELECT vc_Status.vc_StatusID FROM vc_Status where vc_Status.StatusText = 'Finished')
	WHERE vc_VidCast.vc_UserID = @User_ID AND vc_Status.StatusText = 'Finished'
	GROUP BY vc_VidCast.vc_UserID
	
	-- Return @returnvalue to the calling code
	RETURN @returnValue
END
GO

-- Test function
SELECT
	*,
	dbo.vc_VidCastDuration(vc_UserID) as TotalMinutes
FROM vc_User


/* 
	Create a View to hold the TagText and the total number of VidCasts
	that are tagged with that text
*/

CREATE VIEW vc_TagReport AS
	SELECT TOP 15
		vc_Tag.TagText,
		dbo.vc_TagVidCastCount(vc_Tag.vc_TagID) as VidCasts
  	FROM vc_Tag
	ORDER BY VidCasts DESC
GO

-- test new view
SELECT * from vc_TagReport

-- Alter a view to retrieve the top 10 vc_Users and their 
-- VidCast counts adding in the total VidCastDuration
ALTER VIEW vc_MostProlificUsers AS
	SELECT TOP 10
		*,
		dbo.vc_VidCastCount(vc_UserID) as VidCastCount,
		dbo.vc_VidCastDuration(vc_UserID) as TotalMinutes
	FROM vc_User
	ORDER BY VidCastCount DESC
GO

-- Select all from this altered view
SELECT UserName, VidCastCount, TotalMinutes 
	FROM vc_MostProlificUsers