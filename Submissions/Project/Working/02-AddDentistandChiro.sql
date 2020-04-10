-- Add "vaccines" for Dentist which must be Semi-Annual
-- and chiropractor (Chiro) that is Quarterly
INSERT INTO Vaccine
	(Name, Cycle)
		VALUES
			('Dentist', 'Semi-Annual'),
			('Chiro', 'Quarterly')


SELECT * FROM Vaccine