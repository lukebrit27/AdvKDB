//MOCK FEED

/ load required funcs and variables
system"l repo/envs.q";
system"l repo/log.q";
system"l repo/cron.q";
system"l repo/proc.q";


\d .fd
h:hopen `$":",.z.x 0;
tabs:`Quote`Trade;
syms:`IBM`MSFT`FDP`JPM`AAPL;
cnt:count syms;
pxs:syms!"f"$1+cnt?100;
maxtrds:50;

/ ratio of pubbing Quotes:Trades / code can also handle more than 2 tables, just add ratios
ratio:tabs!(0.25;0.75);
if[any not (1f=sum ratio)&(1>=ratio)&0<=ratio;.log.err["Quotes:Trades ratio should be between 0 and 1"];'bad_ratio];
intvls:asc each {$[null y;x,0^y;x,y]} prior  (+\)ratio[tabs];

//within 
wthin:{k:flip y;(x>=k 0)&x<k 1};

/ Generate a spread based on prices
getSpread:{bid:(0.01;b)0<b:x-a:first 1?5f;ask:bid+first 1?a+5f;(bid;ask)};
lastspd:getSpread each pxs;

/ func to generate some quotes
genQuotes:{lastspd[a]::b:getSpread each pxs a:(neg 1+first 1?cnt)?syms;flip .z.P,'a,'b};

/ func to generate some trades
genTrades:{b:lastspd a:(first 1?maxtrds)?syms;prc:b @' (ct:count a)?0b;(ct#.z.p;a;prc;ct?500)};

/ func to pub data
/pub:{(neg h) `.u.upd,a,enlist $[`Trade=a:first tabs where wthin[first 1?1f;intvls];genTrades[];genQuotes[]]};
pub:{@[(neg h);`.u.upd,a,enlist $[`Trade=a:first tabs where wthin[first 1?1f;intvls];genTrades[];genQuotes[]];{.log.out["TP handle ",x," closed."];.cron.del (select actID from .cron.tab where funcName=`.fd.pub)`actID}]};

\d .
/pub initial quotes
(neg .fd.h) `.u.upd,`Quote,enlist enlist[.fd.cnt#.z.p],enlist[.fd.syms],flip value .fd.lastspd;

/pub every 30 secs
.cron.add[`.fd.pub;(::);.z.P;0Wp;1000*30];
/.z.pc:{if[x=.fd.h;.cron.del (select actID from .cron.tab where funcName=`.u.logTickInf)`actID]};
.z.ts:{.cron.run[]};
system "t 1000";
