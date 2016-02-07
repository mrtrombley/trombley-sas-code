*Matt Trombley
*STAT 4020
*3/24/2015;

*1a) Create a simulated data set using DO loops;

data rainfall;
do i=1 to 24;
	if i<=8 then rain=1; else if i>8 AND i<=16 then rain=2; else rain=3;
	if i<=4 then soil=1; else if i>8 AND i<=12 then soil=1; else if i>16 AND i<=20 then soil=1; else soil=2;
	if i<=4 then rep=i; else if i>4 AND i<=8 then rep=i-4; else if i>8 AND i<=12 then rep=i-8; 
		else if i>12 AND i<=16 then rep=i-12; else if i>16 AND i<=20 then rep=i-16; else rep=i-20;
	temp = round(rannor(i) *3 + 14.3,0.1);
	phosph = round(rannor(i) * 3.1 + 41.1,0.1);
	output;
	drop i;
end;
proc print data=rainfall;
run;quit;
