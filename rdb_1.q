//load in rdb template
system "l tick/r.q"

/ subscribe to the ticker plant for Trade and Quote tables
.u.tabs:`Trade`Quote;
.u.sub[];
