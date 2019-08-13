//load in rdb template
system "l tick/r.q";


.u.end:{x;};
.u.tph:(hopen `$":",.u.x 0);
.u.pub:{neg[.u.tph]  (`.u.upd;x;y)};
curMaxStats:([sym:`$()]time:"p"$();maxPrice:"f"$();minPrice:"f"$();maxQty:"j"$();minQty:"j"$());
curQuotes:([sym:`$()];time:"p"$();bestBid:"f"$();bestOffer:"f"$());

//upds
.u.updQuote:{`curQuotes upsert select last time,bestBid:last bid,bestOffer:last ask by sym from x;curQuotes lj curMaxStats};
.u.updMaxStats:{`curMaxStats upsert select time:last time,maxPrice:first (max price)|curMaxStats[([]sym:enlist first sym)]`maxPrice,minPrice:first (min price)&0Wf^curMaxStats[([]sym:enlist first sym)]`minPrice,maxQty:first (max qty)|curMaxStats[([]sym:enlist first sym)]`maxQty,minQty:first (min qty)&0Wj^curMaxStats[([]sym:enlist first sym)]`minQty by sym from x;curQuotes lj curMaxStats};

upd:{rs:MarketInfo upsert $[x=`Quote;.u.updQuote y;x=`Trade;.u.updMaxStats y;()];if[count rs;.u.pub[`MarketInfo;] value flip 0!rs]};

/ subscribe to the ticker plant for Trade and Quote tables
.u.tabs:`Trade`Quote;
.u.sub[];
