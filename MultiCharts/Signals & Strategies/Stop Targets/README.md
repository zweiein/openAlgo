# Stop Targets #
## Signal description: ##

Sets liquidation stops:

- ShareOrPosition
	- 1 = per contract basis | 2 = per position basis 
- ProfitTargetAmt 
	- 0 = off | $ amount for profit target (note: consider tick value)
- StopLossAmt
	- 0 = off | $ amount for stop loss (note: consider tick value)
- BreakevenFloorAmt
	- 0 = off | $ amount of profit to activate break-even exit (note: consider tick value)
- DollarTrailingAmt
	- 0 = off | $ amount of peak retracement enter trailing exit (note: think give back)
- PctTrailingFloorAmt
	- 0 = off | % amount of profit to activate break-even exit (note: XX for percent)
- PctTrailingPct
	- 0 = off | % amount of peak retracement to enter trailing exit (note: XX for percent)
- ExitOnClose
	- true | false (note: use for backtesting only) 

