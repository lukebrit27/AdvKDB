\l ../repo/envs.q

//use this function to create a TP log for Trades for a specfic sym
.rep.createTPLogForSym:{[tpPath;s]
	tp:get tpPath;
	(hsym `$.env.tplogDir,"/tp_",string[s],"_Trades") set tp2 where {y in x[2]`sym}[;s] each  tp2:tp where  tp[;1] like "Trade";
	};




