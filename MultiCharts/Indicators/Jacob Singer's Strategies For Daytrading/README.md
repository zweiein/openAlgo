# Jacob Singer's Strategies For Daytrading #
## Indicator description: ##
Singer calls his first strategy the pivot point. It consists of a symbol and 12 columns of "reports" on that symbol. We have converted the strategy into a RadarScreen page. The column calculations are done in three EasyLanguage documents, each producing four columns. "Perf, Vol & Pivot" includes the performance (net change) column -- upon which the entire RadarScreen is set to continuously report in real time. "!Stops & Tgt Levels," meanwhile, displays the author's key support and resistance prices; while "!BuySell & Alerts" displays the author's key buy/sell bias for the day, and the "bullish," "bearish," or "watch!" real-time setups and alerts. 

## Strategy ##
- Buy at: Plot1( DailyOpen + ( High Low ) / 2 ) ;
- Add: Plot1( ( High Low ) / 2 );
- Gap-Up: if DailyOpen > High[1] then Plot1( 1 ) else Plot1( 0 ) ;

Num of Shares:

- inputs: Capital( 10000 ), Positions( 4 );
- Plot1( Round( Capital / Positions / Last / 50,0 ) * 50 ) ;
- Performance: plot1( ( Last Close[10] ) / Close[10], "Vol" ) ;
- Name: plot1(Description,"Name");