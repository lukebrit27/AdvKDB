//funcs to add monitoring to a process

if[not count key `.log;system"l ",.env.repoDir,"/log.q"];

.mon.logClose:{
	if[count key `.z.PC2;.log.err["Port close monitoring already added!"]];
	$[count key `.z.pc;[.z.PC2:.z.pc;.z.pc:{.log.out["Connection closed by handle ",string x];.z.PC2 x}];[.z.PC2:{};.z.pc:{.log.out["Connection closed by handle ",string x]}]];};


.mon.logOpen:{if[count key `.z.PO2;.log.err["Port open monitoring already added!"]];$[count key `.z.po;[.z.PO2:.z.po;.z.po:{.log.out["Connection opened by handle ",string[x],", ",x".prc.name"];.z.PO2 x}];[.z.PO2:{};.z.po:{.log.out["Connection opened by handle ",string[x],", ",x".prc.name"]}]];};

.mon.addMon:{.mon.logClose[];.mon.logOpen[]};

.mon.mvStdOut:{1 x};
.mon.mvStdErr:{2 x};

.log.out_org:.log.out;
.log.out:{.log.out_org x;.log.out_org .Q.s .Q.w[]};
.mon.addMon[];
