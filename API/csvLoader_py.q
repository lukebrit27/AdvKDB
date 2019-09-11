/embedPy code to read csv and publish to kdb tickerplant
\l p.q
p)import pandas as pd
p)df=pd.read_csv('trade.csv',sep=',',header=None)
p)df=df.values
p)print("Finished reading in data")
pt:.p.pyget`df
qt:.p.py2q pt
/qt:({`$first x}'[qt]),'({"f"$x}'[qt[;1]]),'(qt[;2])
qt:("P"$qt[;0]),'(`$qt[;1]),'({"f"$x}'[qt[;2]]),'(qt[;3])
h:hopen 9010
p)print("Publish to kdb tickerplant")
{h(".u.upd";`Trade;x)}'[qt]
/hclose h;
