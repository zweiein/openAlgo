# Bars

Bars are functions that manipulate or parse a given vector or matrix in to logical format of:   

> OPEN | HIGH | LOW | CLOSE

Although there are benefits for data mining and referencing using Matlab's dataset object,
for a consistent convention for import and export we will use simple arrays. In addition,
as of this writing compiling to MEX does not support the dataset object.

## Functions
| Function | Description |
|:-----|:-----|
|[OHLCSplitter](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Bars/OHLCSplitter)|Parses a given dataset or matrix into individual arrays of `Open`&#124;`High`&#124;`Low`&#124; `Close`|
|[dataSelect](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Bars/dataSelect)|Mapping of the data file to be loaded|
|[insEchos](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Bars/insEchos)|Inserts signal or state echoes in a matrix|
|[remEchos](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Bars/remEchos)|Removes signal or state echoes in a matrix|
|[virtualBars](https://github.com/mtompkins/openAlgo/tree/master/Matlab/Functions/Bars/virtualBars)|Transforms a matrix from a lower observational timeframe to a higher one `e.g. 1 min -> 5 min`|

Author:			Mark Tompkins  
Revision:		5815.15880
