//load in rdb template
system "l tick/r.q"

/ subscribe to the ticker plant for the MarketInfo table
.u.tabs:`MarketInfo;
.u.sub[];
