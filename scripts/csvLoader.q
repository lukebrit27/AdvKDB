system  "l ../repo/envs.q"
system  "l ../tick/schemas.q"

//tp port must be passed as first arg when running this script e.g. q csvLoader.q :9010 mypath/csvFile.csv
.tp.h:hopen `$":",.z.x 0;

.csvs.loadCSV:{[pth] 
	met:exec c!t from (0!meta b:first tables[] where all each (a:`$csv vs raze 1#read0 pth) in/: cols each tables[]);
	b upsert ({?[null x;"*";x]}met a;enlist csv) 0: pth
	}

xx:.csvs.loadCSV hsym `$.z.x 1;
.tp.h `.u.upd,xx,enlist value flip value xx;

