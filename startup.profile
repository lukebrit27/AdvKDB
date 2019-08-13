#####PROCESS PORTS#######
export tp_p_PORT=9010 
export rdb_1_PORT=9011
export rdb_2_PORT=9014
export feed_p_PORT=9013
export rte_1_PORT=9015


export tp_p_STARTUP="tick.q schemas tp_p"
export rdb_1_STARTUP="rdb_1.q :${tp_p_PORT} rdb_1 :9012"
export rdb_2_STARTUP="rdb_2.q :${tp_p_PORT} rdb_2 :9012" 
export feed_p_STARTUP="feed/feed.q :${tp_p_PORT} feed_p"
export rte_1_STARTUP="rte_1.q :${tp_p_PORT} rte_1 :9012"
