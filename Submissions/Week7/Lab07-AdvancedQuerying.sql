SELECT 
	vc_User.Username, 
		vc_User.EmailAddress, 
		vc_VidCast.vc_VidCastID 
FROM vc_VidCast 
JOIN vc_User on vc_User.vc_Userid = vc_VidCast.vc_UserID 
ORDER BY vc_User.Username

SELECT * FROM vc_User
	WHERE vc_UserID NOT IN (SELECT vc_UserID FROM vc_VidCast)

SELECT
	vc_User.UserName,
	vc_User.EmailAddress,
	vc_VidCast.vc_VidCastID
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
ORDER BY vc_user.UserName

SELECT
	COUNT(vc_VidCastID) as NumberOfVidCasts,
	SUM(ScheduleDurationMinutes) as TotalScheduledMinutes,
	MIN(ScheduleDurationMinutes) as MinScheduledMinutes,
	AVG(ScheduleDurationMinutes) as AvgScheduledMinutes,
	MAX(ScheduleDurationMinutes) as MaxScheduledMinutes
FROM vc_VidCast


-- This will generate an error ---
SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	COUNT(vc_VidCast.vc_VidCastID) CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
ORDER BY vc_User.UserName


-- this one is correct ---
SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	COUNT(vc_VidCast.vc_VidCastID) CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY
	vc_User.UserName,
	vc_User.EmailAddress
ORDER BY vc_User.UserName

SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	COUNT(vc_VidCast.vc_VidCastID) CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY
	vc_User.UserName,
	vc_User.EmailAddress
ORDER BY CountOfVidCasts DESC

SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	COUNT(vc_VidCast.vc_VidCastID) CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY
	vc_User.UserName,
	vc_User.EmailAddress
HAVING COUNT(vc_VidCast.vc_VidCastID) < 10
ORDER BY CountOfVidCasts DESC, vc_User.UserName

SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	SUM(DateDIff(n, StartDateTIme, EndDateTime)) as SumActualDurationMinutes
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
JOIN vc_Status on vc_Status.vc_StatusID = vc_VidCast.vc_StatusID
WHERE vc_Status.StatusText = 'Finished'
GROUP BY
	vc_User.UserName,
	vc_User.EmailAddress
ORDER BY vc_User.UserName


-- Adding count of VidCasts, minimum, average and maximum durations for each vc_User record. 
-- Sorting by by descending count of videos and then by UserName
SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	SUM(DateDIff(n, StartDateTIme, EndDateTime)) as SumActualDurationMinutes,
	COUNT(vc_VidCastID) as CountOfVidCasts,
	MIN(DateDIff(n, StartDateTIme, EndDateTime)) as MinActualDurationMinutes,
	AVG(DateDIff(n, StartDateTIme, EndDateTime)) as AvgActualDurationMinutes,
	MAX(DateDIff(n, StartDateTIme, EndDateTime)) as MaxActualDurationMinutes
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
JOIN vc_Status on vc_Status.vc_StatusID = vc_VidCast.vc_StatusID
WHERE vc_Status.StatusText = 'Finished'
GROUP BY
	vc_User.UserName,
	vc_User.EmailAddress
ORDER BY CountOfVidCasts DESC, vc_User.UserName



