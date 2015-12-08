# SIGNAL functions

A `signal` is an actionable array that can be passed to a P&L function for analysis and is generated from one or more `state` conditions resolving to Boolean **TRUE** or **FALSE**.  

A given `signal` output has one of three outputs:

| Signal Output | Action |
| ------------- | ------ |
|SIGNAL < 0|**Sell**|
|SIGNAL = 0|No action|
|SIGNAL > 0|**Buy**|

The output value should be the number of contracts to be bought or sold.

**Simple Signals:**
> Logically: **BUY** IF Price > Moving Average    

----

**Advanced Signals:** By leveraging fractions as additional `signal` logic, we are able to construct more meaningful instructions beyond the scope of a simple **Buy** or **Sell** quantity **'X'**. As you can't **Buy** or **Sell** 1/2 a contract, we encode advanced instructions in the fractional element of `signal` arrays.

> Example: We desire to close any existing Long position and establish an opposite Short position.    
> Logically: REVERSE IF Moving Average < Price

**Convention:**    
'NET' is a current net position:

| NET | SIGNAL | ACTION | Description |
| --- | ------ | ------ | ----------- |
|any|0|none|A zero signal is an evaluated false to a possible state trigger and instructs to 'do nothing'.|
|any|X (integer)|Buy or Sell X|An integer instructs to BUY or SELL quantity X|
|any|+/- 0.5 (fraction)|Close Any Opposite Position|Close out any opposite existing position such that a NET = 0 flat condition exists. Ignore in the case of same direction. If no position exists, no error is thrown|
|||||
|<=0|X.5 (fraction)|Reverse to position NET = X|Close out any existing short position and buy X longs to create a long position such that NET = X|
|>=0|-X.5 (fraction)|Reverse to position NET = -X|Close out any existing long position and sell X shorts to create a short position such that NET = -X|


		NOTE: This convention maintains compatibility basic signals.
**Examples:**

|EX 1|Without fractional logic|With fractional logic|
|:--:|------------------------|---------------------|
|begin|NET = -1|NET = -1|
||SIGNAL = 2|SIGNAL = 1.5|
|end|NET = 1|NET = 1|

|EX 2|Without fractional logic|With fractional logic|
|:--:|------------------------|---------------------|
|begin|NET = -50|NET = -50|
||SIGNAL = 51|SIGNAL = 1.5|
|end|NET = 1|NET = 1|

|EX 3|Without fractional logic|With fractional logic|
|:--:|------------------------|---------------------|
|begin|NET = -50|NET = -50|
||SIGNAL = 55|SIGNAL = 5.5|
|end|NET = 5|NET = 5|				


**FUNDAMENTAL CONSIDERATIONS:**

	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	!!!! STATES MAY OR MAY NOT REPEAT PER OBSERVATION !!!!
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	!!!!    SIGNALS SHOULD BE CLEAN AND NOT REPEAT    !!!!
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

 Revision:		4937.18292  
