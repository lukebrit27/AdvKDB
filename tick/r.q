/q tick/r.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]
/2008.09.09 .k ->.q
/ load required funcs and variables
system"l repo/envs.q";
system"l repo/log.q";
system"l repo/cron.q";
system"l repo/proc.q";
system"l repo/utils.q";
system"l tick/schemas.q";
if[not "w"=first string .z.o;system "sleep 1"];

//tables to subscribe to
if[not count key `.u.tabs;.u.tabs:()];

/upd:upsert;
upd:{if[x in .u.tabs;x upsert y]};

/ get the ticker plant and history ports, defaults are 5010,5012
if[not (count .z.x 0)&count .z.x 2;.log.err["Port of tp or hdb has not been specified!"];'specify_port];
.u.x:.z.x 0 2;

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;kys:.u.rmKey each kytabs:t where 98h=type each key each t;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;kys xkey' kytabs;};
.u.rmKey:{x set 0!a:get x;cols key a};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].)each $[1=count first x;enlist x;x];if[null first y;:()];if[count .u.tabs;-11!last y];system "cd ",.env.hdbDir};
/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log))
.u.sub:{.u.rep .(hopen `$":",.u.x 0)"(.u.sub[;`] each `",("`" sv string .utils.enl .u.tabs),";`.u `i`L)";};
/ 

