# PAR #

PAR functions are wrappers for the embarrassingly parallel parametric sweeps of vectorized observations.

>PAR sweeps are coded for finding an optimum Sharpe ratio.    

>PARMETS sweep for an optimum `shMETS` value.    
Input data is bifurcated:    

>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;80% `test` (test set)    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;20% `val` (validation set)    

>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![Image](http://mathurl.com/jm665du)

>MEXPAR require the MEX'd version of the associated function

# Functions ##
| Description | Function |
|:-----|:-----|
|Bollinger Bands|[bollBandPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/bollBandPARMETS.m)|
|Bollinger Bands & Profit Taking|[bollBandNumTicksPftPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/bollBandNumTicksPftPARMETS.m)|
|Ehler's iTrend & MovAvg|[iTrendMAPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/iTrendMAPAR.m)|
|Ehler's iTrend & RAVI|[iTrendRaviPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/iTrendRaviPARMETS.m)|
|MovAvg (2 inputs)|[ma2inputsPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma2inputsPAR.m)|
|MovAvg (2 inputs)|[ma2inputsMEXPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma2inputsMEXPAR.m)|
|MovAvg (2 inputs & Profit Taking|[ma2inputsNumTicksPftPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma2inputsNumTicksPftPARMETS.m)|
|MovAvg (2 inputs @ 2 vectors) & Profit Taking|[ ma2inputsNumTicksPft2vBarsPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma2inputsNumTicksPft2vBarsPARMETS.m)|
|MovAvg (3 inputs)|[ma3inputsPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma3inputsPAR.m)|
|MovAvg (3 inputs)|[ma3inputsPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/ma3inputsPARMETS.m)|
|MovAvg & RAVI|[maRaviPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/maRaviPARMETS.m)|
|MovAvg & RSI|[maRsiPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/maRsiPAR.m)|
|MovAvg & RSI|[maRsiPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/maRsiPARMETS.m)|
|MovAvg & SNR|[maSnrPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/maSnrPARMETS.m)|
|RSI|[rsiPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/rsiPAR.m)|
|RSI & RAVI|[rsiRaviPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/rsiRaviPARMETS.m)|
|Williams' %R|[wprPAR.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/wprPAR.m)|
|Williams' Dynamic %R|[wprDynPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/wprDynPARMETS.m)|
|Williams' Dynamic %R & Profit Taking|[wprDynNumTicksPftPARMETS.m](https://github.com/mtompkins/openAlgo/blob/master/Matlab/Functions/PAR/wprDynNumTicksPftPARMETS.m)|




Author: Mark Tompkins  
Revision: 4902.23648
