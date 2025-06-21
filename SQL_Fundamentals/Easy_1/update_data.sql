/*
It seems there was a mistake when we were inserting data in the birds table. 
All the crows are actually ravens. Update the birds table so that the rows
with a species of 'Crow' now read 'Raven'.
*/

UPDATE birds SET species TO 'Raven' WHERE species = 'Crow';

/*
Oops. Jamie isn't an Owl - he's a Hawk. Correct his information.
*/

UPDATE birds SET species To 'Hawk' WHERE name = 'Jamie';