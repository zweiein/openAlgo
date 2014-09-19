# METS Exits #
## Signal description: ##

Sets liquidation based on a variety of logic

- **ProfitTarget** = Profit Target By Ticks
- **InitStop** = Initial Stop Loss By Ticks
- **PctTrailing** = Percent Trailing Stop
	- InitPctTicks - Number of ticks in position direction to activate % trail 
	- PctTrailPct - Percentage to trail from peak positive equity
- **TickTrailing** = Tick Trailing Stop
	- NumTicksTrail - Number of ticks to trail stop
	- NumTicksActivate - Number of ticks in position direction to activate tick trail stop
- **NumBarsExit** - Number of Bars Exit
	- NumBarsExit - number of bars since entry force exit

