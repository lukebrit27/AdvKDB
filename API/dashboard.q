// run with q API/dashboard.q
// only works with tp port 9010
system"l repo/envs.q";
upd:insert;


system"p 9016";
tpH:hopen 9010;
.u.init:{ system "l tick/schemas.q"; {tpH(`.u.sub;x;`)} each `Trade`Quote;};
.u.init[];
lf:{system"l ",.env.codeDir,"/API/dashboard.q";}
.z.ws:{value x};
.z.wc:{delete from `subs where handle=x;}
/* subs table to keep track of current subscriptions */
subs:2!flip `handle`func`params!"is*"$\:();
/* functions to be called through WebSocket */
loadPage:{
 getSyms[.z.w];
 sub[`getTrades;enlist`];
 }
filterSyms:{sub[`getTrades;x]};
getSyms:{(neg[x]) .j.j `func`result!(`getSyms;distinct Trade`sym);}
getTrades:{
 filter:$[all raze null x;distinct Trade`sym;raze x];
 res:reverse 0!select Time:time,Sym:sym,Price:price,Size:qty from Trade where sym in filter;
 :`func`result!(`getTrades;res);
 }
// subscribe to something 
sub:{`subs upsert(.z.w;x;enlist y);}
// publish data according to subs table 
pub:{
 row:(0!subs)[x];
 :(neg row[`handle]) .j.j (value row[`func])[row[`params]];
 }
// refresh every 100ms
.z.ts:{
 pub each til count subs;
 }
\t 100
