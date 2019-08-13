.log.h:hopen hsym`$.log.path:.env.logDir,"_" sv ("/",.z.x[1];string .z.D;string 1+count where (key hsym  `$.env.logDir) like .z.x[1],"_",string[.z.D],"*");

.log.out:{.log.h {x,"\n"}" ### " sv (string .z.P;string .z.h;"normal";(x;enlist x) 0>type x);};
.log.err:{.log.h {x,"\n"}" ### " sv (string .z.P;string .z.h;"ERROR";(x;enlist x) 0>type x);};
