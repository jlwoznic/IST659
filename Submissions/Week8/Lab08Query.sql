-- Declare a variable
declare @isThisNull varchar(30) -- Starts out as NULL
SELECT @isThisNull, ISNULL(@isThisNull, 'Yep, it is null') -- see?

-- Set the variable to somethin gother than NULL
SET @isThisNull = 'Nope. It is not NULL'
SELECT @isThisNull, ISNULL(@isThisNull, 'Yep, it is no null') -- how about now??

CREATE FUNCTION dbo.AddTwoInts(@firstNumber int, @secondNumber int)
RETURNS int AS
BEGIN
	-- First, declare the variable to temporarily hold the result
	DECLARE @returnValue int -- the data time matches the RETURNS clause

	-- Do whatever needs to be done to set that variable to the correct value
	SET @returnValue = @firstNumber + @secondNumber

	-- Return the value to the calling statement
	RETURN @returnValue

END
GO

SELECT dbo.AddTwoInts(5,10)


-- Function to count the VidCasts made by given User
CREATE FUNCTION dbo.vc_VidCastCount(@userID int)
RETURNS int AS -- COUNT() is an integer value, so return it as an int
BEGIN
	DECLARE @returnValue int -- matches the function's return type

	/*
		Get the count of the VidCasts for the provided UserID and 
		assign that value to @returnValue. Note that we use the 
		@userID parameter in the WHERE clause to limit our count 
		to that user's VidCast recrods.
	*/
	SELECT @returnValue = COUNT(vc_UserID) FROM vc_VidCast
	WHERE vc_VidCast.vc_UserID = @userID
	
	-- Return @returnvalue to the calling code
	RETURN @returnValue

END
GO

SELECT TOP 10
	*,
	dbo.vc_VidCastCount(vc_userID) as VidCastCount
FROM vc_User
ORDER BY VidCastCount DESC


GO
-- Function to retrieve the vc_TagID for a given tag's text
CREATE FUNCTION dbo.vc_TagIDLookup(@tagText varchar(20))
RETURNS int AS -- vc_TagID is an int, so we will match that
BEGIN
	DECLARE @returnValue int -- Matches the function's return type

	/*
		Get the vc_TagID of the vc_Tag record whose TagText
		matches the parameter and assign that value to @returnValue
	*/
	SELECT @returnValue = vc_TagID FROM vc_Tag
	WHERE TagText = @tagText
	
	-- Send the vc_TagID back to the caller
	RETURN @returnValue
END
GO

-- Test our function
SELECT dbo.vc_TagIDLookup('Music')
SELECT dbo.vc_TagIDLookup('Tunes')

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

-- Create a procedure to update a vc_User's email address
-- the first parameter is the user name for the user to change
-- the second is the new email address
CREATE PROCEDURE vc_ChangeUserEmail(@userName varchar(20), @newEmail varchar(50))
AS
BEGIN
	UPDATE vc_User SET EmailAddress = @newEmail
	WHERE UserName = @userName
END
GO

-- Execute the stored procedure
EXEC vc_ChangeUserEmail 'tardy', 'kmstudent@syr.edu'
SELECT * from vc_User WHERE UserName = 'tardy'


INSERT INTO vc_Tag (TagText) VALUES ('Cat Videos')
SELECT * FROM vc_Tag WHERE vc_TagID = @@identity

/* 
	Create a procedure that adds a row to the UserLogin tabl
	This procedure is run when a user logs in and we need
	to record who they are and from where they're logging in
*/

CREATE PROCEDURE vc_AddUserLogin(@userName varchar(20), @loginFrom varchar(50))
AS
BEGIN
	-- We have the user name, but we need tthe ID for the login table
	-- First, declare a variable to hold the ID
	DECLARE @userID int

	-- Get the vc_userID for the UserName provided and store it in the UserID
	SELECT @userID = vc_UserID FROM vc_User
	WHERE UserName = @userName

	-- Now we can add the row using the INSERT statement
	INSERT INTO vc_UserLogin (vc_userID, LoginLocation)
	VALUES (@userID, @loginFrom)

	-- Now return the @@identity (unique identity key) so the calling code 
	-- knows where the data ended up
	RETURN @@identity

END
GO
	
DECLARE @addedValue int
EXEC @addedValue = vc_AddUserLogin 'tardy', 'localhost'
SELECT
	vc_User.vc_UserID,
	vc_User.UserName,
	vc_UserLogin.userLoginTimestamp,
	vc_UserLogin.LoginLocation
FROM vc_user
JOIN vc_UserLogin on vc_User.vc_UserID = vc_UserLogin.vc_UserID
WHERE vc_UserLoginID = @addedValue

/* 
	Create a function to retrieve a vc_UserID for a given user name
*/
CREATE FUNCTION dbo.vc_UserIDLookup(@userName varchar(20))
RETURNS int AS
BEGIN
	DECLARE @returnValue int

	-- TODO: Write the code to assign the correct vc_UserID
	--		 to @returnValue

	SELECT @returnValue = vc_UserID FROM vc_User
	WHERE UserName = @userName

	RETURN @returnValue
END
GO

SELECT 'Trying the vc_UserIDLookup function.', dbo.vc_UserIDLookup ('tardy')

/*
	Create a fucntion called dbo.vc_TagVidCastCount that calculates the count
	of vc_VidCastIDs for a given vc_TagID.

*/

CREATE FUNCTION dbo.vc_TagVidCastCount(@Tag_ID int)
-- COUNT() is an integer value, so return it as an int
RETURNS int AS 
BEGIN
	DECLARE @returnValue int -- matches the function's return type
	/*
		Get the count of the VidCasts for the provided TagID and 
		assign that value to @returnValue. Note that we use the 
		@TagID parameter in the WHERE clause to limit our count 
		to those VidCast with the TagID passed to the function.
	*/
	SELECT @returnValue = COUNT(vc_VidCastID) 
		FROM vc_VidCastTagList
	JOIN vc_Tag on vc_VidCastTagList.vc_TagID = vc_Tag.vc_TagID
	WHERE vc_VidCastTagList.vc_TagID = @Tag_ID
	
	-- Return @returnvalue to the calling code
	RETURN @returnValue
END
GO

-- Test function
SELECT
	vc_Tag.TagText, 
	dbo.vc_TagVidCastCount(vc_Tag.vc_TagID) as VidCasts
FROM vc_Tag

/* 
	Function vc_VidCastDuration that sums the total number of minutes of
	actual duration of VidCasts with a Finished Status given a specific
	vc_UserID as a parameter. Should return the SUM as an integer
*/

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


/*
	Create a stored procedure to add a new Tag to the database
	Inputs:
		@Tag_Text : the text of the new tag
		@description : a brief description of the tag (nullable)
	Returns:
		@@identity with the value inserted
*/

CREATE PROCEDURE vc_AddTag(@Tag_Text varchar(20), @description varchar(100)=NULL) AS
BEGIN
	--- Code Procedure Here
	INSERT INTO vc_Tag
		(TagText, TagDescription)
		VALUES
			(@Tag_Text, @description)
	RETURN @@identity
END
GO

DECLARE @newTagID int
EXEC @newTagID = vc_AddTag 'SQL', 'Finally, a SQL Tag'
SELECT * FROM vc_Tag WHERE vc_TagID = @newTagID

/*
	vc_FinishVidCast Stored Procedure
		Inputs : @Vid_CastID (integer) - that will need to be marked as Finished

	To accomplish this, we need to change the EndDateTime in the vc_VidCast table to the current date/time - GetDate()
	and then change the StatusID on the Vid_CastID to match the vc_StatusID in the Status table for Finished
	- the change vc_StatusID will be updated to this value in the vc_VidCast table
*/

CREATE PROCEDURE vc_FinishVidCast(@Vid_CastID int) AS
BEGIN
	--- Code Procedure Here
	-- Update the VidCast EndDate to now
	UPDATE vc_VidCast 
		SET 
			vc_StatusID = (SELECT vc_StatusID FROM vc_Status WHERE StatusText = 'Finished'),
			EndDateTime = GETDATE()

	WHERE vc_VidCastID = @Vid_CastID
	RETURN @@identity
END
GO

DECLARE @newVC int
INSERT INTO vc_VidCast
	(VidCastTitle, StartDateTime, ScheduleDurationMinutes, vc_UserID, vc_StatusID)
	VALUES
		('Finally done with sprocs', 
		 DATEADD(n, -45, GETDATE()),
		 45,
		 (SELECT vc_UserID FROM vc_User WHERE UserName = 'tardy'),
		 (SELECT vc_StatusID FROM vc_Status WHERE StatusText = 'Started'))

SET @newVC = @@identity
SELECT * FROM vc_VidCast WHERE vc_VidCastID = @newVC
EXEC vc_FinishVidCast @newVC
SELECT * FROM vc_VidCast WHERE vc_VidCastID = @newVC 
				 