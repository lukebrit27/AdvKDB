//1st ARG: Path to TP log
//2nd ARG: Path to HDB dir
//3rd ARG dt of partition
//Example Run: q eodFromTP.q ../tplogs/tp_2019.08.25 ../hdb 2019.03.18


//first arg should be path to tplog
tp:hsym `$.z.x 0;

//second arg should be path to hdb
hdbDir:{$["/"=last x;x;x,"/"]} .z.x 1;

// date to save down
dt:"D"$.z.x 2;
dtPth:hsym `${$["/"=last x;x;x,"/"]}hdbDir,string dt;

upd:{[t;d]
	$[count key td:hsym `$hdbDir,string[dt],"/",string[t],"/";td upsert .Q.en[hsym `$hdbDir;d];td set .Q.en[hsym `$hdbDir;d]];	
	}; 

-11!tp;

// compress cols except sym, time and .d
{{-19!(x;x; 16; 1; 0)} each `$/: (td,"/"),/: string value `.d`sym`time _a!a:key[`$td:string[dtPth],string x]} each key[dtPth];

