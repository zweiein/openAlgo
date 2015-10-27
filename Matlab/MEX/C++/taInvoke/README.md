# taInvoke wrapper #
taInvoke.cpp is a wrapper for calling the open source ta-lib library through a compiled mex routine.  
mexOpts.txt contains the paths for the ta-lib C source files to be passed when mex'ing in MatLab
	
	mex taInvoke.cpp @mexOpts

The ta-library is available from [http://www.ta-lib.org](http://www.ta-lib.org "http://www.ta-lib.org")

If the size of the compiled taInvoke file is of concern, the individual functions can be mex'd individually and called.  This may be useful in HPC parametric sweeps to minimize data transfer of unused functions in the larger compilation.

To produce a list of available functions in the MatLab command window, execute:

	taInvoke

To produce information on any specific function in the MatLab command window, execute:

	taInvoke('function')

## ta-lib Functions ##
Note: Markup language with two underscores causes a misrepresentation below. Names with two underscores have the 2nd underscore omitted. To properly reference the function in MatLab, replace the space between words with an underscore. There are no spaces in these function names.

- ta_ACCBANDS
- ta_ACOS
- ta_AD
- ta_ADD
- ta_ADOSC
- ta_ADX
- ta_ADXR
- ta_APO
- ta_AROON
- ta_AROONOSC
- ta_ASIN
- ta_ATAN
- ta_ATR
- ta_AVGDEV
- ta_AVGPRICE
- ta_BBANDS
- ta_BETA
- ta_BOP
- ta_CCI
- ta_CDL2CROWS
- ta_CDL3BLACKCROWS
- ta_CDL3INSIDE
- ta_CDL3LINESTRIKE
- ta_CDL3OUTSIDE
- ta_CDL3STARSINSOUTH
- ta_CDL3WHITESOLDIERS
- ta_CDLABANDONEDBABY
- ta_CDLADVANCEBLOCK
- ta_CDLBELTHOLD
- ta_CDLBREAKAWAY
- ta_CDLCLOSINGMARUBOZU
- ta_CDLCONCEALBABYSWALL
- ta_CDLCOUNTERATTACK
- ta_CDLDARKCLOUDCOVER
- ta_CDLDOJI
- ta_CDLDOJISTAR
- ta_CDLDRAGONFLYDOJI
- ta_CDLENGULFING
- ta_CDLEVENINGDOJISTAR
- ta_CDLEVENINGSTAR
- ta_CDLGAPSIDESIDEWHITE
- ta_CDLGRAVESTONEDOJI
- ta_CDLHAMMER
- ta_CDLHANGINGMAN
- ta_CDLHARAMI
- ta_CDLHARAMICROSS
- ta_CDLHIGHWAVE
- ta_CDLHIKKAKE
- ta_CDLHIKKAKEMOD
- ta_CDLHOMINGPIGEON
- ta_CDLIDENTICAL3CROWS
- ta_CDLINNECK
- ta_CDLINVERTEDHAMMER
- ta_CDLKICKING
- ta_CDLKICKINGBYLENGTH
- ta_CDLLADDERBOTTOM
- ta_CDLLONGLEGGEDDOJI
- ta_CDLLONGLINE
- ta_CDLMARUBOZU
- ta_CDLMATCHINGLOW
- ta_CDLMATHOLD
- ta_CDLMORNINGDOJISTAR
- ta_CDLMORNINGSTAR
- ta_CDLONNECK
- ta_CDLPIERCING
- ta_CDLRICKSHAWMAN
- ta_CDLRISEFALL3METHODS
- ta_CDLSEPARATINGLINES
- ta_CDLSHOOTINGSTAR
- ta_CDLSHORTLINE
- ta_CDLSPINNINGTOP
- ta_CDLSTALLEDPATTERN
- ta_CDLSTICKSANDWICH
- ta_CDLTAKURI
- ta_CDLTASUKIGAP
- ta_CDLTHRUSTING
- ta_CDLTRISTAR
- ta_CDLUNIQUE3RIVER
- ta_CDLUPSIDEGAP2CROWS
- ta_CDLXSIDEGAP3METHODS
- ta_CEIL
- ta_CMO
- ta_CORREL
- ta_COS
- ta_COSH
- ta_DEMA
- ta_DIV
- ta_DX
- ta_EMA
- ta_EXP
- ta_FLOOR
- ta_HT DCPERIOD
- ta_HT DCPHASE
- ta_HT PHASOR
- ta_HT SINE
- ta_HT TRENDLINE
- ta_HT TRENDMODE
- ta_KAMA
- ta_LINEARREG
- ta_LINEARREG ANGLE
- ta_LINEARREG INTERCEPT
- ta_LINEARREG SLOPE
- ta_LN
- ta_LOG10
- ta_MA
- ta_MACD
- ta_MACDEXT
- ta_MACDFIX
- ta_MAMA
- ta_MAVP
- ta_MAX
- ta_MAXINDEX
- ta_MEDPRICE
- ta_MIDPOINT
- ta_MIDPRICE
- ta_MIN
- ta_MININDEX
- ta_MINMAX
- ta_MINMAXINDEX
- ta_MINUS DI
- ta_MINUS DM
- ta_MFI
- ta_MOM
- ta_MULT
- ta_NATR
- ta_OBV
- ta_PLUS DI
- ta_PLUS DM
- ta_PPO
- ta_ROC
- ta_ROCP
- ta_ROCR
- ta_ROCR100
- ta_RSI
- ta_SAR
- ta_SAREXT
- ta_SMA
- ta_SIN
- ta_SINH
- ta_SQRT
- ta_STDDEV
- ta_STOCH
- ta_STOCHF
- ta_STOCHRSI
- ta_SUB
- ta_SUM
- ta_T3
- ta_TAN
- ta_TANH
- ta_TEMA
- ta_TRANGE
- ta_TRIMA
- ta_TRIX
- ta_TSF
- ta_TYPPRICE
- ta_ULTOSC
- ta_WCLPRICE
- ta_WILLR
- ta_WMA
- ta_VAR

