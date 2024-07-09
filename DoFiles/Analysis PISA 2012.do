//Cycle 2012
//Set aestetic format
set scheme tufte
//Open data for Student, School, Teacher
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality\Data\PISA 2012 (Stata)"
	//Build Data model for Student/School/Teacher
use "PISA2012_students.dta", clear
merge m:1 cnt schoolid using PISA2012_schools.dta
drop _merge
//Set workspace for statitics pv = math,read,scie
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality"
//Setting Survey Data
svyset [pweight = W_FSTUWT], brr(W_FSTURWT*) vce(brr) fay(.5) mse
//List of countries
groups cnt  cntryid
