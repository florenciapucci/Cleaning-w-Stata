/*******************************************
*                                          *  
*             CODING EXERCISE              *
*			  			                   *  
********************************************/

*autor: Florencia Iara Pucci
*date: 16/04/4021

************************************
********FIRST PART: CLEANING********
************************************

*Clears memory
clear all

*Saves path in global

global main ""
global output "$main/output"


*Sets directory
cd "$output"


* Opens database, sets first row as variable's names
 
import delimited "$main\...", encoding(UTF-8) varnames (1) clear


*Removes header

drop in 1/19


*Keeps only key variables 

keep finished responseid q21 q22 q23 q24 q25 q26 q27 q28 q411 q51 q52_1 q52_2 q53_1 q53_2 q54_1 q54_2 q55_1 q55_2 q56_1 q56_2 q57_1 q57_2 q58_1 q58_2 q59_1 q59_2 q510_1 q510_2 q511_1 q511_2 q512_1 q512_2 q513 q514 surveyexperiment_do


*Drops observations of individuals who didn't finish the survey or whose response id is missing

drop if finished == "False"

drop if missing(responseid)


*Rename some variables

ren q21 gender
ren q22 age 
ren q23 state
ren q24 educ
ren q25 income
ren q411 cashtransfer
ren q51 progb
ren q28 attcheck
ren surveyexperiment_do treatment


*Creates value labels for dummy variables values and encodes the variables

label define gender2 0 "Male" 1 "Female"
encode gender, gen(gender2) 

label define progb2 0 "No, I would recommend that the government offer Program A only." 1 "Yes, I would recommend that the government offer Program B as an alternative to Program A." 
encode progb, gen(progb2)

label define finished2 0 "False" 1 "True"
encode finished, gen(finished2)

drop gender progb finished
ren gender2 gender
ren progb2 progb
ren finished2 finished


*Creates value labels for categorical variables and encodes the variables


label define age2 0 "18-24" 1 "25-29" 2 "30-34" 3 "35-39" 4 "40-44" 5 "45 or over"
encode age, gen(age2)
drop age
ren age2 age

label define income2 0 "$10,000 - $29,999" 1 "$30,000 - $59,999" 2 "$60,000 - $90,000" 3 "Over $90,000" 4 "Under $10,000"
encode income, gen(income2)
drop income
ren income2 income

label define q26b 0 "Conservative" 1 "Liberal" 2 "Moderate" 3 "Very conservative" 4 "Very liberal" 
encode q26, gen(q26b)
drop q26
ren q26b q26

label define state2 0 "Alabama" 1 "Arizona" 2 "Arkansas" 3 "California" 4 "Colorado" 5"Connecticut" 6 "Delaware" 7 "Florida" 8 "Georgia" 9 "Idaho" 10 "Illinois" 11 "Indiana" 12 "Iowa" 13 "Kansas" 14 "Kentucky" 15 "Louisiana" 16 "Maine" 17 "Maryland" 18 "Massachusetts" 19 "Michigan" 20 "Minnesota" 21 "Mississippi" 22 "Missouri" 23 "Nebraska" 24 "Nevada" 25 "New Hampshire" 26 "New Jersey" 27 "New Mexico" 28 "New York" 29 "North Carolina" 30 "Ohio" 31 "Oklahoma" 32 "Oregon" 33 "Pennsylvania" 34 "Rhode Island" 35 "South Carolina" 36 "South Dakota" 37 "Tennessee" 38 "Texas" 39 "Utah" 40 "Vermont" 41 "Virginia" 42 "Washington" 43 "West Virginia" 44 "Wisconsin"
encode state, gen(state2)
drop state
ren state2 state

label define educ2 0 "College degree" 1 "High school degree or equivalent" 2 "Less than high school diploma" 3 "Post-graduate degree"
encode educ, gen(educ2)
drop educ
ren educ2 educ

label define q27b 0 "Independent" 1 "Moderate Democrat" 2 "Moderate Republican" 3 "Strong Democrat" 4 "Strong Republican" 
encode q27, gen(q27b)
drop q27
ren q27b q27

label define attcheck2 0 "Enthusiastic,Irritable" 1 "Interested" 2 "Interested,Excited,Strong,Proud,Alert,Inspired,Attentive,Active" 3 "Interested,Excited,Strong,Proud,Alert,Inspired,Determined,Attentive" 4 "Interested,Proud,Alert,Active" 5 "None of the above"
encode attcheck, gen(attcheck2)
drop attcheck
ren attcheck2 attcheck

label define q513b 0 "Equally likely Program A or B" 1 "More likely Program A" 2 "More likely Program B" 3 "Very likely Program A" 4 "Very likely Program B" 
encode q513, gen(q513b)
drop q513
ren q513b q513

*Treatment variable: changes value names with more intuitive name, define value labels and encodes it

replace treatment="Baseline: No Info" if treatment=="t_4.1_4.11|Q4.1|Q4.3|Q4.11"
replace treatment="Baseline: Hard Working" if treatment=="t_4.1_4.11|Q4.1|Q4.2|Q4.11"
replace treatment="Baseline: Lazy" if treatment=="t_4.1_4.11|Q4.1|Q4.4|Q4.11"
replace treatment="Job Search: Hard Working" if treatment=="t_4.1_4.11|Q4.1|Q63|Q4.11"
replace treatment="Job Search: Lazy" if treatment=="t_4.1_4.11|Q4.1|Q65|Q4.11"
replace treatment="College: Hard Working" if treatment=="t_4.1_4.11|Q4.1|Q66|Q4.11"
replace treatment="College: No Info" if treatment=="t_4.1_4.11|Q4.1|Q67|Q4.11"
replace treatment="College: Lazy" if treatment=="t_4.1_4.11|Q4.1|Q68|Q4.11"


label define treatment2 8 "Baseline: Hard Working" 1 "Baseline: Lazy" 2 "Baseline: No Info" 3 "College: Hard Working" 4 "College: Lazy" 5 "College: No Info" 6 "Job Search: Hard Working" 7 "Job Search: Lazy" 
encode treatment, gen(treatment2)
drop treatment
ren treatment2 treatment


*Labels data

label data "This file contains survey data from a survey experiment conducted in Oct 2017"


*Labels variables: Background Variables

/* q21 "Please indicate your gender"*/

label var gender "Gender"

/* q22 "How old are you?"*/

label var age "Age"

/* q23 "What state do you live in?"*/

label var state "State of residence"

/* q24 "Please indicate the highest level of formal education that you have completed"*/

label var educ "Highest level of formal education completed"

/* q25 "Please indicate your current annual household income in U.S. dollars"*/

label var income "Current annual household income in U.S. dollars"

/* q26 "On economic policy matters, where do you see yourself on the liberal/conservative spectrum?" */

label var q26 "Economic spectrum"

/* q27 "Generally speaking, do you usually think of yourself as a Republican,
Democrat or Independent?"*/

label var q27 "Political party preferences"

/* q28 Attention check. Respondant should check the 'none of the above' option if he is attentive*/

label var attcheck "Attention check"


*Labels variables: Experimental Variables

/* q411 "What amount of cash transfer would you give to this individual?"*/

label var cashtransfer "Cash Transfer per week"

/* q51 "Given that program A was already offered to the individual, would you recommend that the government offer Program B as an alternative?"*/

label var progb "Alternative program recommendation"

/* q52_1 and q52_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $0 per week in q411*/

label var q52_1 "Cash transfer per week when q51 answer was affirmative and q411=0"
label var q52_2 "Work req in hours per week when q51 answer was affirmative and q411=0"

/* q53_1 and q53_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $20 per week in q411*/

label var q53_1 "Cash transfer per week when q51 answer was affirmative and q411=20"
label var q53_2 "Work req in hours per week when q51 answer was affirmative and q411=20"

/* q54_1 and q54_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $40 per week in q411*/

label var q54_1 "Cash transfer per week when q51 answer was affirmative and q411=40"
label var q54_2 "Work req in hours per week when q51 answer was affirmative and q411=40"

/* q55_1 and q55_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $60 per week in q411*/

label var q55_1 "Cash transfer per week when q51 answer was affirmative and q411=60"
label var q55_2 "Work req in hours per week when q51 answer was affirmative and q411=60"

/* q56_1 and q56_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $80 per week in q411*/

label var q56_1 "Cash transfer per week when q51 answer was affirmative and q411=80"
label var q56_2 "Work req in hours per week when q51 answer was affirmative and q411=80"

/* q57_1 and q57_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $100 per week in q411*/

label var q57_1 "Cash transfer per week when q51 answer was affirmative and q411=100"
label var q57_2 "Work req in hours per week when q51 answer was affirmative and q411=100"

/* q58_1 and q58_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $120 per week in q411*/

label var q58_1 "Cash transfer per week when q51 answer was affirmative and q411=120"
label var q58_2 "Work req in hours per week when q51 answer was affirmative and q411=120"

/* q59_1 and q59_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $140 per week in q411*/

label var q59_1 "Cash transfer per week when q51 answer was affirmative and q411=140"
label var q59_2 "Work req in hours per week when q51 answer was affirmative and q411=140"

/* q510_1 and q510_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $160 per week in q411*/

label var q510_1 "Cash transfer per week when q51 answer was affirmative and q411=160"
label var q510_2 "Work req in hours per week when q51 answer was affirmative and q411=160"

/* q511_1 and q511_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $180 per week in q411*/

label var q511_1 "Cash transfer per week when q51 answer was affirmative and q411=180"
label var q511_2 "Work req in hours per week when q51 answer was affirmative and q411=180"

/* q512_1 and q512_2 "Please tell us which combination of cash transfer and work requirement you would offer to this individual for Program B." Only showed to respondants whose answer was affirmative in q51 and had selected $200 per week in q411*/

label var q512_1 "Cash transfer per week when q51 answer was affirmative and q411=200"
label var q512_2 "Work req in hours per week when q51 answer was affirmative and q411=200"

/* q513 "Do you think the individual will choose Program A or Program B?" Only showed to respondants whose answer was affirmative in q51*/

label var q513 "Opinion over individual's choice"

/* q514 "Could you please explain why you did or did not recommend the Program B option?*/

label var q514 "Explanation of decision in cashtransfer"

/* surveyexperiment_do indicates group of treatment */

label var treatment "Treatment assignment"


*Generates dummies for categorical variables


tabulate age, gen(agerange)
tabulate state, gen(state)
tabulate educ, gen(educlevel)
tabulate income, gen(incomelevel)
tabulate q26, gen(economicideology)
tabulate q27, gen(politicalparty)
tabulate q513, gen(opinion)
tabulate treatment, gen(treatment2)


*Destrings numeric variables

replace cashtransfer = regexr(cashtransfer, "\((.)+\)", "")
replace cashtransfer = regexr(cashtransfer, "per week", "")
replace cashtransfer = subinstr(cashtransfer, "$", "",.) 
destring cashtransfer, replace

foreach var of varlist q52_1 q53_1 q54_1 q55_1 q56_1 q57_1 q58_1 q59_1 q510_1 q511_1 q512_1 {
replace `var' = regexr(`var', "\((.)+\)", "")
replace `var' = regexr(`var', "per week", "")
replace `var' = subinstr(`var', "$", "",.) 
destring `var', replace
}

foreach var of varlist q52_2 q53_2 q54_2 q55_2 q56_2 q57_2 q58_2 q59_2 q510_2 q511_2 q512_2 {
replace `var' = regexr(`var', "hours per week", "")
replace `var' = regexr(`var', "hour per week", "")
replace `var' = regexr(`var', "hours", "")
replace `var' = regexr(`var', "hour", "")
destring `var', replace
}


*************************************
**********SECOND PART: TABLE*********
*************************************

*Note: couldn't replicate the entire table. Sorry. 



*Generates 3 new variables, one for each group of treatments, and labels the values of them

gen Baseline =.
replace Baseline=0 if treatment==2  //No info
replace Baseline=1 if treatment==8  //Hard working
replace Baseline=2  if treatment==1 //Lazy

label define Baseline 0 "Noinfo" 1 "HardWorking" 2 "Lazy"
label values Baseline Baseline

gen JobSearch=.
replace JobSearch=0 if treatment==2  //No info
replace JobSearch=1 if treatment==6  //Hard working
replace JobSearch=2  if treatment==7 //Lazy

label define JobSearch 0 "Noinfo" 1 "HardWorking" 2 "Lazy"
label values JobSearch JobSearch

gen College=.
replace College=0 if treatment==5  //No info
replace College=1 if treatment==3  //Hard working
replace College=2  if treatment==4 //Lazy

label define College 0 "Noinfo" 1 "HardWorking" 2 "Lazy"
label values College College


*Creates a column vector for the means of the baseline group's treatments

preserve
drop if missing(Baseline)
collapse (mean) cashtransfer, by (Baseline)
mkmat cashtransfer, mat(A)
mat list A
restore

*Creates a column vector for the means of the jobsearch group's treatments

preserve
drop if missing(JobSearch)
collapse (mean) cashtransfer, by (JobSearch)
mkmat cashtransfer, mat(B)
mat list B
restore

*Creates a column vector for the means of the college group's treatments

preserve
drop if missing(College)
collapse (mean) cashtransfer, by (College)
mkmat cashtransfer, mat(C)
mat list C
restore

*Creates a column vector for the SE of the baseline group's treatments

preserve
drop if missing(Baseline)
collapse (sem) cashtransfer, by (Baseline)
mkmat cashtransfer, mat(D)
mat list D
restore

*Creates a column vector for the SE of the jobsearch group's treatments

preserve
drop if missing(JobSearch)
collapse (sem) cashtransfer, by (JobSearch)
mkmat cashtransfer, mat(F)
mat list F
restore

*Creates a column vector for the SE of the college group's treatments

preserve
drop if missing(College)
collapse (sem) cashtransfer, by (College)
mkmat cashtransfer, mat(G)
mat list G
restore


*This code creates a table that has in it's columns the 6 matrices created before. It also exports the table in .tex format. 

frmttable, statmat(A) sdec(2) title(Table 5: Average generosity in cash transfers across treatment arms in Survey 2) ctitle("", "Baseline") rtitle("Hard Working"\"Lazy"\"No Info") note("Notes: Data from Survey 2 (N = 808). Respondents were put in the hypothetical position in which the United States government appoints them to choose policies that would aid poor families. We provided the respondent with a description of the household that would benefit from the social assistance, and we randomized some information in this description. \ The three panels show the additional information that was included in the description \ of the hypothetical scenario. No-Info corresponds to the baseline information \ (i.e., no further information added). After the description, respondents  \ were asked to recommend to the government a cash transfer for this beneficiary. We present the mean of the amount of unconditional cash transfer \ that the subjects recommended in the hypothetical scenario and their standard errors.") 

frmttable, statmat(D) sdec(3) ctitle("", "SE") rtitle("Hard Working"\"Lazy"\"No Info") merge
frmttable, statmat(B) sdec(2) ctitle("", "Job Search") rtitle("Hard Working"\"Lazy"\"No Info") merge
frmttable, statmat(F) sdec(3) ctitle("", "SE") rtitle("Hard Working"\"Lazy"\"No Info") merge
frmttable, statmat(C) sdec(2) ctitle("", "College") rtitle("Hard Working"\"Lazy"\"No Info") merge
frmttable using table5, statmat(G) sdec(3) ctitle("", "SE") rtitle("Hard Working"\"Lazy"\"No Info") tex merge


************************************
********THIRD PART: GRAPH 1*********
************************************


set scheme s2color, perm 

grmeanby Baseline College JobSearch, summarize(cashtransfer) ytitle(Cash Transfer per week) ytitle(, size(medlarge)) title("")
graph export graph10.png, replace wid(1000)


**************************************
*********FOURTH PART: GRAPH 2*********
**************************************

**This graph aims to show if there are state outliers in every treatment group, relative to cashtransfers


*Creates a variable that contains the mean of cashtransfer by state
bysort state: egen m_cashtransfer=mean(cashtransfer)


*Graphs that show cash transfer per state per group of treatment 
twoway (scatter m_cashtransfer state if treatment==8, mlabel(state) ytitle(Cash Transfer per week) xtitle(Baseline: Hard Working)), saving (graph1)
twoway (scatter m_cashtransfer state if treatment==1, mlabel(state) ytitle(Cash Transfer per week) xtitle(Baseline: Lazy)), saving (graph2)
twoway (scatter m_cashtransfer state if treatment==2, mlabel(state) ytitle(Cash Transfer per week) xtitle(Baseline: No Info)), saving (graph3)
twoway (scatter m_cashtransfer state if treatment==6, mlabel(state) ytitle(Cash Transfer per week) xtitle(Job Search: Hard Working)), saving (graph4)
twoway (scatter m_cashtransfer state if treatment==7, mlabel(state) ytitle(Cash Transfer per week) xtitle(Job Search: Lazy)), saving (graph5)
twoway (scatter m_cashtransfer state if treatment==3, mlabel(state) ytitle(Cash Transfer per week) xtitle(College: Hard Working)), saving (graph6)
twoway (scatter m_cashtransfer state if treatment==5, mlabel(state) ytitle(Cash Transfer per week) xtitle(College: No Info)), saving (graph7)
twoway (scatter m_cashtransfer state if treatment==4, mlabel(state) ytitle(Cash Transfer per week) xtitle(College: Lazy)), saving (graph8)


*Graph that combines all graphs
gr combine graph1.gph graph2.gph graph3.gph graph4.gph graph5.gph graph6.gph graph7.gph graph8.gph, saving(outlierspergroup) title("")

graph export outlierspergroup1.png, replace wid(1000)

*If we look at the graphs for each group, there seems to be some states that present average cash transfer values very different from the total mean. To check if dropping one state change the results, the following loop is performed:

**************************************
*********FIFTH PART: OUTLIERS*********
**************************************


*This loop calculates the means for every treatment group leaving out one state at a time

egen group = group(state) 
su group, meanonly

 foreach i of num 1/`r(max)' {
 preserve 
 drop if group == `i'
 tabstat cashtransfer, by(treatment) statistics(mean sd N) columns(statistics) nototal
 restore
  }
 
*The results remain unchanged when the states are dropped one by one from the database. 


*Save new database
 
 save data_ready_for_analysis
 
 
 ****END

