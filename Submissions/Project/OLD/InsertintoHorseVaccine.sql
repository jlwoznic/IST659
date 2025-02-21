/*
	Author: Joyce Woznica
	Course: IST659 M400
	Term:	Fall 2018
	Project: Horse Vaccination Project
*/

-- Insert into the HorseVaccine table
-- Notice that there is no ID first column (HorseVaccineID) as this is an identity integer and
-- cannot be inserted
-- This will also need to be updated when the microchip data is available
INSERT INTO HorseVaccine
            (HorseID, VaccineID, VaccineBatch, VaccineDate, VaccineScheduledDate, VaccineCost, VetID)
    VALUES
        ('1','1','','5/29/2018','',67.00,'CTE1'),
        ('1','2','','5/29/2018','',47.00,'CTE1'),
        ('1','3','','5/29/2018','',50.00,'CTE1'),
        ('1','4','','5/29/2018','',48.00,'CTE1'),
        ('1','5','','5/29/2018','',47.00,'CTE1'),
        ('1','6','','2/23/2018','',40.00,'CTE1'),
        ('1','7','','12/1/2017','11/15/2018',30.00,'LKW1'),
        ('1','8','','12/1/2017','11/15/2018',33.00,'LKW1'),
        ('1','9','','12/10/2017','11/15/2018',25.00,'CTE2'),
        ('2','1','','5/29/2018','',67.00,'CTE1'),
        ('2','2','','5/29/2018','',47.00,'CTE1'),
        ('2','3','','5/29/2018','',50.00,'CTE1'),
        ('2','4','','5/29/2018','',48.00,'CTE1'),
        ('2','5','','5/29/2018','',47.00,'CTE1'),
        ('2','6','','2/23/2018','',40.00,'CTE1'),
        ('2','7','','12/1/2017','11/15/2018',30.00,'LKW1'),
        ('2','8','','12/1/2017','11/15/2018',33.00,'LKW1'),
        ('2','9','','12/10/2017','11/15/2018',25.00,'CTE2'),
        ('3','1','MER-14084A','5/7/2018','',67.00,'ASC1'),
        ('3','3','','5/7/2018','',50.00,'CTE1'),
        ('3','4','','5/7/2018','',48.00,'CTE1'),
        ('3','5','','5/7/2018','',47.00,'CTE1'),
        ('3','7','','10/15/2018','',30.00,'SVP1'),
        ('4','1','','5/29/2018','',67.00,'CTE1'),
        ('4','2','','5/29/2018','',47.00,'CTE1'),
        ('4','3','','5/29/2018','',50.00,'CTE1'),
        ('4','4','','5/29/2018','',48.00,'CTE1'),
        ('4','5','','5/29/2018','',47.00,'CTE1'),
        ('4','6','','2/17/2018','',40.00,'CTE3'),
        ('4','7','','11/29/2017','11/29/2018',40.00,'CTE2'),
        ('4','8','','11/29/2017','11/29/2018',62.00,'CTE2'),
        ('4','9','','11/23/2017','11/29/2018',25.00,'CTE2'),
        ('5','1','','5/29/2018','',67.00,'CTE1'),
        ('5','2','','5/29/2018','',47.00,'CTE1'),
        ('5','3','','5/29/2018','',50.00,'CTE1'),
        ('5','4','','5/29/2018','',48.00,'CTE1'),
        ('5','5','','5/29/2018','',47.00,'CTE1'),
        ('5','6','','2/17/2018','',40.00,'CTE3'),
        ('5','7','','11/29/2017','11/29/2018',40.00,'CTE2'),
        ('5','8','','11/29/2017','11/29/2018',62.00,'CTE2'),
        ('5','9','','11/23/2017','11/29/2018',25.00,'CTE2'),
        ('6','1','','5/29/2018','',67.00,'CTE1'),
        ('6','2','','5/29/2018','',47.00,'CTE1'),
        ('6','3','','5/29/2018','',50.00,'CTE1'),
        ('6','4','','5/29/2018','',48.00,'CTE1'),
        ('6','5','','5/29/2018','',47.00,'CTE1'),
        ('6','6','','2/17/2018','',40.00,'CTE3'),
        ('6','7','','11/29/2017','11/29/2018',40.00,'CTE2'),
        ('6','8','','11/29/2017','11/29/2018',62.00,'CTE2'),
        ('6','9','','11/23/2017','11/29/2018',25.00,'CTE2'),
        ('1','7','','11/14/2018','11/14/2019',32.00,'SVP1'),
        ('1','8','','11/14/2018','11/14/2019',28.00,'SVP1'),
        ('1','9','','11/14/2018','11/14/2019',11.00,'SVP1'),
        ('1','10','','11/14/2018','',45.00,'SVP1'),
        ('1','10','','5/29/2018','',60.00,'CTE1'),
        ('2','7','','11/14/2018','11/14/2019',32.00,'SVP1'),
        ('2','8','','11/14/2018','11/14/2019',28.00,'SVP1'),
        ('2','9','','11/14/2018','11/14/2019',11.00,'SVP1'),
        ('2','10','','11/14/2018','',45.00,'SVP1'),
        ('3','8','','11/14/2018','11/14/2019',28.00,'SVP1'),
        ('3','9','','11/14/2018','11/14/2019',11.00,'SVP1'),
        ('3','10','','11/14/2018','',45.00,'SVP1'),
        ('2','10','','5/29/2018','',60.00,'CTE1'),
        ('4','10','','5/29/2018','',60.00,'CTE1'),
        ('5','10','','5/29/2018','',60.00,'CTE1'),
        ('6','10','','5/29/2018','',60.00,'CTE1'),
        ('3','4','','11/14/2018','11/14/2019',43.00,'SVP1')
-- End Insert

-- Verify results
SELECT * FROM HorseVaccine
	ORDER by HorseVaccineID

