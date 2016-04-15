*Question 1;

DM 'log;clear;out;clear;';
OPTIONS NODATE NONUMBER;

*1b) Create a format for the gender variable;

PROC FORMAT;
	VALUE $gendertag 'M'='Male'
					'F'='Female';

*1a) Add in the data using datalines;

DATA gym;
INPUT ID Gender $ Age Vault Floor PBar;

	DATALINES;
	3 M 8 7.5 7.2 6.5
	5 F 14 7.9 8.2 6.8
	2 F 10 5.6 5.7 5.8
	7 M 9 5.4 5.9 6.1
	6 F 15 8.2 8.2 7.9
	;

DATA gymincome;
LENGTH ID 8 Income $8 LastName $10;
INPUT ID Income $ LastName $;

	DATALINES;
	3 A Klein
	7 B Cesar
	8 A Solanchick
	1 B Warlock
	5 A Cassidy
	2 B Volick
	;

PROC PRINT data=gym;
PROC PRINT data=gymincome;
RUN;
QUIT;

*1b) Use the format tag when printing out the data;

PROC PRINT data=gym;
var ID Gender;
FORMAT Gender $gendertag.;
RUN;
QUIT;

*1c) Delete male & non-teenage entries from the table to create a teenage female subset;

DATA fem;
SET gym;
	IF Gender='M' THEN DELETE;
	IF Age<13 THEN DELETE;
PROC PRINT data=fem;
FORMAT Gender $gendertag.;
RUN;
QUIT;

*1d) Sort the data by ID and merge it to create a new data set;

PROC SORT data=gym; BY ID;
PROC SORT data=gymincome; BY ID;
DATA gymall;
merge gym gymincome; BY ID;
PROC PRINT data=gymall;
FORMAT Gender $gendertag.;
RUN;
QUIT;


*Question 2;


DM 'LOG;CLEAR;OUT;CLEAR;';
OPTIONS NODATE NONUMBER;

DATA tdf;
length rider $ 30 TeamName $ 27;

*2a) Add the Tour De France data file into SAS with the INFILE and INPUT statements;

INFILE 'D:\tdf2012.csv' DSD dlm=',' FIRSTOBS=2;
INPUT Rider $ TeamName $ BirthYear Height Weight Nation $ s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20;

*2b) Create two new variables- LastName and FirstName;

LastName = substr(Rider, 1, index(Rider, ' ')-1);
FirstName = substr(Rider, index(Rider, ' ')+1);

*2c) Create a new variable (stagesum) that is the sum of all stage times;

stagesum = sum(of s0-s20);

*2b) Print the two new variables with TeamName;

PROC PRINT DATA=tdf;
var LastName FirstName TeamName;
RUN;
QUIT;

*2c) Print the first 5 observations from the United States with variables LastName, FirstName, TeamName, and stagesum;

PROC PRINT DATA=tdf (obs=5);
 where nation='USA';
 var LastName FirstName TeamName stagesum;
RUN;
QUIT;
