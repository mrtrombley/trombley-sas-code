DM 'LOG;CLEAR;OUT;CLEAR;';
OPTIONS NODATE NONUMBER;

*1a) Read the data in using INFILE and INPUT;

DATA tdf;
length Rider $ 30 TeamName $ 27;

INFILE 'D:\tdf2012.csv' DSD dlm=',' FIRSTOBS=2;
INPUT Rider $ TeamName $ BirthYear Height Weight Nation $ s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20;

PROC PRINT DATA=tdf;
RUN;
QUIT;

*1b) Creata new data set with three teams and a stagesum variable;

data tdfnew;
set tdf;
 IF TeamName='BMC RACING TEAM' OR TeamName='GARMIN-SHARP' or TeamName='TEAM EUROPCAR';
stagesum = sum(of s0-s20);
PROC SORT; by TeamName Rider;
PROC PRINT DATA=tdfnew (obs=5);
var TeamName Rider stagesum;
RUN;
QUIT;

*1c) Create side-by-side box-and-whisker plots for stagesum vs. team;

PROC BOXPLOT;
title 'Sum of Tour De France Stage Times';
PLOT stagesum*TeamName;
label stagesum = 'Sum of Rider''s Stage Times (seconds)'
TeamName='Name of Racing Team';
RUN;
QUIT;

*1d) Create a scatterplot of stagesum vs. stage 1 time for the three teams;

PROC GPLOT;
SYMBOL1 VALUE=CIRCLE COLOR=BLUE;
SYMBOL2 VALUE=SQUARE COLOR=GREEN;
SYMBOL3 VALUE=TRIANGLE COLOR=RED;
title 'Stage 1 Times vs. Sum of Stage Times For Tour De France Riders';
	PLOT stagesum*s1=TeamName;
	label stagesum = 'Sum of Rider''s Stage Times (seconds)'
	s1 = 'Stage 1 Time'
	TeamName = 'Name of Racing Team';
RUN;
QUIT;

*1e) Find sample size, mean, standard deviation, and a 90% CI for the data;

title;
PROC MEANS maxdec=3 N mean std ALPHA=0.1 CLM;
class TeamName;
var height Weight stagesum;
run;quit;
