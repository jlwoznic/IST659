-- Get the cycle and convert that to number of months to add to date
CREATE FUNCTION NumMonths (@Vaccine_ID int)
	RETURNS int AS
	BEGIN
		DECLARE @returnValue as int

		SELECT @returnValue = CASE
				WHEN Cycle = 'Annual' THEN 12
				WHEN Cycle = 'Semi-Annual' THEN 6
				ELSE 3
			END
		FROM Vaccine WHERE VaccineID = @Vaccine_ID
	-- return the number of months
	RETURN @returnValue
END
GO

-- Run this function to determine the number of months to add to Semi-Annual vaccines
-- for example
SELECT dbo.NumMonths (7)
SELECT dbo.NumMonths (4)

