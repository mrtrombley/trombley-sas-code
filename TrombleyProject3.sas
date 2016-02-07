*Matt Trombley;
*STAT 4020;
*Project 3;
*2/26/2015;

DM 'LOG;CLEAR;OUT;CLEAR;';
OPTIONS NODATE NONUMBER;

*Part E- initializing PROC FORMAT and setting the names for the nation codes;

PROC FORMAT;
	VALUE $countrycode 'AUS'='Australia'
				'USA'='United States of America'
				'GER'='Germany'
				'GBR'='Great Britain'
				'BEL'='Belgium';
DATA tdf;
length rider $ 30 team $ 27;

*Part A- reading in the data using INFILE and INPUT;

INFILE 'D:\tdf2012.csv' DSD dlm=',' FIRSTOBS=2;
INPUT rider $ team $ birth height weight nation $ s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20;

*Part D- assigning a descriptive label to all the variables;

LABEL rider='Name of Rider'
	team='Name of Team'
	birth='Year of Birth'
	height='Height (cm)'
	weight='Weight (kilograms)'
	nation='Nation'
	s0='Stage 0 Time'
	s1='Stage 1 Time'
	s2='Stage 2 Time'
	s3='Stage 3 Time'
	s4='Stage 4 Time'
	s5='Stage 5 Time'
	s6='Stage 6 Time'
	s7='Stage 7 Time'
	s8='Stage 8 Time'
	s9='Stage 9 Time'
	s10='Stage 10 Time'
	s11='Stage 11 Time'
	s12='Stage 12 Time'
	s13='Stage 13 Time'
	s14='Stage 14 Time'
	s15='Stage 15 Time'
	s16='Stage 16 Time'
	s17='Stage 17 Time'
	s18='Stage 18 Time'
	s19='Stage 19 Time'
	s20='Stage 20 Time';
FORMAT nation $countrycode.;

*Part A- print the first five observations;
*Part D- outputting label to the results viewer;
*Part E- printing the rider, team, and nation variables;

PROC PRINT DATA=tdf (obs=5) LABEL;
	var rider team nation;

*Part C- describing the data using PROC CONTENTS;

PROC CONTENTS DATA=tdf;
RUN;
QUIT;
