//Cycle 2015
//Set aestetic format
set scheme tufte
//Open data for Student, School, Teacher
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality\Data\PISA 2015 (Stata)"
	//Build Data model for Student/School/Teacher
use "PISA2015_students.dta", clear
merge m:1 cnt cntschid using PISA2015_schools.dta
drop _merge
//Set workspace for statitics pv = math,read,scie
cd "C:\Users\SEBASTIAN\Documents\MA Social Science\Social Stratification II\PISA and Inequality"
//Setting Survey Data
svyset [pweight = W_FSTUWT], brr(W_FSTURWT*) vce(brr) fay(.5) mse
//List of countries
groups cnt  cntryid
//Country Codes: COL CHL ARG** URY PAN PER MEX
//This year ARG was spell it out due to sample issue
//Scores: Cycle '2015,2018 and Subject 'Math, Science, Read'
//Create a variable to recode Parental Education
gen paredintforcal =  pared
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

//By Parental Education (I)
	//Colombia
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "COL", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "COL", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "COL", by(paredintforcal)
	//Chile
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "CHL", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "CHL", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "CHL", by(paredintforcal)
	//Brazil
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "BRA", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "BRA", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "BRA", by(paredintforcal)
	//Uruguay
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "URY", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "URY", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "URY", by(paredintforcal)
	//Pamana
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PAN", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PAN", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PAN", by(paredintforcal)
	//Peru
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PER", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PER", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PER", by(paredintforcal)
	//Mexico
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "MEX", by(paredintforcal)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "MEX", by(paredintforcal)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "MEX", by(paredintforcal)

//By Gender (II)
	//Colombia
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "COL", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "COL", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "COL", by( ST004D01T)
	//Chile
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "CHL", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "CHL", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "CHL", by( ST004D01T)
	//Brazil
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "BRA", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "BRA", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "BRA", by( ST004D01T)
	//Uruguay
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "URY", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "URY", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "URY", by( ST004D01T)
	//Pamana
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PAN", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PAN", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PAN", by( ST004D01T)
	//Peru
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PER", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PER", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PER", by( ST004D01T)
	//Mexico
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "MEX", by( ST004D01T)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "MEX", by( ST004D01T)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "MEX", by( ST004D01T)

//By School Type (III)
	//Colombia
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "COL", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "COL", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "COL", by(schltype)
	//Chile
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "CHL", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "CHL", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "CHL", by(schltype)
	//Brazil
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "BRA", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "BRA", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "BRA", by(schltype)
	//Uruguay
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "URY", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "URY", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "URY", by(schltype)
	//Pamana
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PAN", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PAN", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PAN", by(schltype)
	//Peru
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PER", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PER", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PER", by(schltype)
	//Mexico
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "MEX", by(schltype)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "MEX", by(schltype)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "MEX", by(schltype)

//By Immingrant Status (IV)
	//Colombia
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "COL", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "COL", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "COL", by(immig)
	//Chile
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "CHL", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "CHL", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "CHL", by(immig)
	//Brazil
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "BRA", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "BRA", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "BRA", by(immig)
	//Uruguay
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "URY", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "URY", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "URY", by(immig)
	//Pamana
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PAN", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PAN", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PAN", by(immig)
	//Peru
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PER", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PER", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PER", by(immig)
	//Mexico
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "MEX", by(immig)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "MEX", by(immig)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "MEX", by(immig)

//By Childhood Care (V)
	//Colombia
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "COL", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "COL", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "COL", by(durecec)
	//Chile
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "CHL", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "CHL", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "CHL", by(durecec)
	//Brazil
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "BRA", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "BRA", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "BRA", by(durecec)
	//Uruguay
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "URY", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "URY", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "URY", by(durecec)
	//Pamana
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PAN", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PAN", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PAN", by(durecec)
	//Peru
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "PER", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "PER", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "PER", by(durecec)
	//Mexico
ineqdeco  PV1MATH[pweight=W_FSTUWT] if cnt == "MEX", by(durecec)
ineqdeco  PV1READ[pweight=W_FSTUWT] if cnt == "MEX", by(durecec)
ineqdeco  PV1SCIE[pweight=W_FSTUWT] if cnt == "MEX", by(durecec)


