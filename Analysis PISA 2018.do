//Cycle 2018
//Set aestetic format
set scheme tufte
//Open data for Student, School, Teacher
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality\Data\PISA 2018 (Stata)"
	//Build Data model for Student/School/Teacher
use "PISA2018_students.dta", clear
merge m:1 cnt cntschid using PISA2018_schools.dta
drop _merge
//Set workspace for statitics pv = math,read,scie
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality"
//Setting Survey Data
svyset [pweight=w_fstuwt], brr(w_fstur*) vce(brr) fay(.5) mse
//List of countries
groups cnt  cntryid
//Country Codes: COL CHL ARG URY PAN PER MEX
//Scores: Cycle '2015,2018 and Subject 'Math, Science, Read'
//Create a variable to recode Parental Education
gen paredintforcal =  paredint
//Recode the Parental Education (paredint)
recode paredintforcal 0/6 = 0 7/12 = 1 8/max = 2

//Scores
	//Cycle 2018
pisastats, stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(MATH2018) fast
pisastats, stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(READ2018) fast
pisastats, stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(SCIE2018) fast
	//Cycle 2015
pisastats, stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(MATH2015) fast
pisastats, stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(READ2015) fast
pisastats, stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(SCIE2015) fast
	//Cycle 2012
pisastats, stats("mean sd p10 p90") pv(math) cnt(COL ARG URY MEX) cycle(2012) save(MATH2012) fast
pisastats, stats("mean sd p10 p90") pv(read) cnt(COL ARG URY MEX) cycle(2012) save(READ2012) fast
pisastats, stats("mean sd p10 p90") pv(scie) cnt(COL ARG URY MEX) cycle(2012) save(SCIE2012) fast
pisastats , stats("mean sd p10 p90") pv(math) cnt(ALL) cycle(2012) save(MATH2012) fast

//Immigrant status (immig)
	//Cycle 2018
pisastats, over(immig) stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(MATHIMMG2018) fast
pisastats, over(immig) stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(READIMMG2018) fast
pisastats, over(immig) stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(SCIEIMMG2018) fast
	//Cycle 2015
pisastats, over(immig) stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(MATHIMMG2015) fast
pisastats, over(immig) stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(READIMMG2015) fast
pisastats, over(immig) stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(SCIEIMMG2015) fast

//Durantion of early Childhoodcare (durecec)
	//Cycle 2018
pisastats, over(durecec) stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(MATHdurecec2018) fast
pisastats, over(durecec) stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(READdurecec2018) fast
pisastats, over(durecec) stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2018) save(SCIEdurecec2018) fast
	//Cycle 2015
pisastats, over(durecec) stats("mean sd p10 p90") pv(math) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(MATHdurecec2015) fast
pisastats, over(durecec) stats("mean sd p10 p90") pv(read) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(READdurecec2015) fast
pisastats, over(durecec) stats("mean sd p10 p90") pv(scie) cnt(COL CHL ARG URY PAN PER MEX) cycle(2015) save(SCIEdurecec2015) fast

//Checchi-Peragine Tranche Approach: G(0): 

// Men Log Deviatin (MLD) = 1/N*SUMi-->N(MeanPV/PVi) = G(0)[total]/G(0) between-groups

ineqdeco pv1math [pweight=w_fstuwt], by(cntryid)

//By Gender (II)
	//Colombia
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "COL", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "COL", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "COL", by(st004d01t)
	//Chile
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "CHL", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "CHL", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "CHL", by(st004d01t)
	//Argentina
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "ARG", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "ARG", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "ARG", by(st004d01t)
	//Brazil
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "BRA", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "BRA", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "BRA", by(st004d01t)
	//Uruguay
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "URY", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "URY", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "URY", by(st004d01t)
	//Pamana
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PAN", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PAN", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PAN", by(st004d01t)
	//Peru
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PER", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PER", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PER", by(st004d01t)
	//Mexico
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "MEX", by(st004d01t)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "MEX", by(st004d01t)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "MEX", by(st004d01t)

//By School Type (III)
	//Colombia
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "COL", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "COL", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "COL", by(schltype)
	//Chile
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "CHL", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "CHL", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "CHL", by(schltype)
	//Argentina
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "ARG", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "ARG", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "ARG", by(schltype)
	//Brazil
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "BRA", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "BRA", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "BRA", by(schltype)
	//Uruguay
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "URY", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "URY", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "URY", by(schltype)
	//Pamana
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PAN", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PAN", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PAN", by(schltype)
	//Peru
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PER", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PER", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PER", by(schltype)
	//Mexico
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "MEX", by(schltype)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "MEX", by(schltype)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "MEX", by(schltype)

//By Immingrant Status (IV)
	//Colombia
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "COL", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "COL", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "COL", by(immig)
	//Chile
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "CHL", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "CHL", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "CHL", by(immig)
	//Argentina
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "ARG", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "ARG", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "ARG", by(immig)
	//Brazil
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "BRA", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "BRA", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "BRA", by(immig)
	//Uruguay
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "URY", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "URY", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "URY", by(immig)
	//Pamana
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PAN", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PAN", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PAN", by(immig)
	//Peru
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PER", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PER", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PER", by(immig)
	//Mexico
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "MEX", by(immig)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "MEX", by(immig)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "MEX", by(immig)

//By Childhood Care (V)
	//Colombia
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "COL", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "COL", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "COL", by(durecec)
	//Chile
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "CHL", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "CHL", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "CHL", by(durecec)
	//Argentina
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "ARG", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "ARG", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "ARG", by(durecec)
	//Brazil
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "BRA", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "BRA", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "BRA", by(durecec)
	//Uruguay
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "URY", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "URY", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "URY", by(durecec)
	//Pamana
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PAN", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PAN", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PAN", by(durecec)
	//Peru
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PER", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PER", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PER", by(durecec)
	//Mexico
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "MEX", by(durecec)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "MEX", by(durecec)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "MEX", by(durecec)

//By SES (VI)
	//Colombia
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "COL", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "COL", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "COL", by(paredintforcal)
	//Chile
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "CHL", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "CHL", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "CHL", by(paredintforcal)
	//Argentina
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "ARG", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "ARG", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "ARG", by(paredintforcal)
	//Brazil
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "BRA", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "BRA", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "BRA", by(paredintforcal)
	//Uruguay
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "URY", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "URY", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "URY", by(paredintforcal)
	//Pamana
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PAN", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PAN", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PAN", by(paredintforcal)
	//Peru
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "PER", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "PER", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "PER", by(paredintforcal)
	//Mexico
ineqdeco pv1math[pweight=w_fstuwt] if cnt == "MEX", by(paredintforcal)
ineqdeco pv1read[pweight=w_fstuwt] if cnt == "MEX", by(paredintforcal)
ineqdeco pv1scie[pweight=w_fstuwt] if cnt == "MEX", by(paredintforcal)
