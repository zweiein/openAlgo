# Elementals #

Elementals are functions that are fundamental and atomic calculations.

As a general statement elementals should:

> - return either a scalar or vector as a result    
> - not call any other function other than another elemental function

They should **not** return a `Signal` or `State` directly.  This allows code corrections without need for downstream edits.

For example, to create a moving average crossover system one would:


1. Create a moving average elemental function
2. Create a moving average `State` function incorporating two averages and their per observation relationship
3. Create a moving average `Signal` function that interprets the `State` output and creates an actionable `Signal`.

> elemental function &#8594;`State` &#8594; `Signal`  

**Mexing**:   Elemental functions should always be coded in such a fashion as they can be mex'd.

## Functions ##
| Function | Description |
|:-----|:-----|
|[ascRange](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/ascRange)|Creates a dynamic self-adjusting lookback period. |
|[atr](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/atr)|Average True Range|
|[bollBand](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/bollBand)|Bollinger Bands|
|[iTrend](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/iTrend)|Ehler's Instantaneous Trend|
|[iTrend_v2](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/iTrend_v2)|Ehler's Instantaneous Trend - Modified|
|[movAvg](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/movAvg)|Moving Averages|
|[pricerange](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/pricerange)|Calculates the difference between two observations|
|[ravi](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/ravi)|Chande's Range Action Verification Index|
|[snr](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Elementals/snr)|Signal To Noise Ratio|

Author: Mark Tompkins  
Revision: 5815.17014
