# MultiCharts Repository #
This section contains files coded with MultiChart's PowerLanguage. While not 100% equivalent to TradeStation's EasyLanguage, it is a very similar type pseudocode and most scripts may be used with TradeStation with little modification.

Although there may be ELD files available from time to time in the repository, the preferred method of posting PowerLanguage content is through text file so that PowerLanguage code may be easily seen and freely distributed without the need to import code in to the editor.  

While this approach does create a higher likelihood of a missing referenced called function that is not of a common nature, I believe the value of publicly viewable code to be considerably more in line with the spirit of openAlgo. In my experience too much code has been lost to the mechanics of any given vendor's approach to import and export.

Where possible original author's comments have been left intact to give appropriate credit. Some of this content while old, is still believed to be valuable. In addition, code has been acquired from many sources including culling from the internet. In the event proprietary code has been posted here that shouldn't be public and there is a claim to intellectual property, please reach out to me directly and I will address it professionally.

## C++ DLLs
This directory contains a git repository submodule. When cloning openAlgo this subfolder will not automatically pull the contents [Reference: http://www.git-scm.com/book/en/Git-Tools-Submodules](http://www.git-scm.com/book/en/Git-Tools-Submodules "Git-Tools-Submodules"). 

To pull the submodule content execute:

    git submodule init
    git submodule update

To update the submodule content execute:

	git submodule update --remote --merge
For a listing of DLL based functions see the submodule directory README file.

## Functions ##
- [AddTime](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Functions/AddTime "AddTime")
- [Colors](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Functions/Colors "Colors")
- [EquityCurveStdDev](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Functions/EquityCurveStdDev "EquityCurveStdDev")
- [MinTick](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Functions/MinTick "MinTick")

## Indicators ##
- [3 Higher](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/3%20Higher "3 Higher" "3 Higher")
- [BB Squeeze](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/BB%20Squeeze "BB Squeeze") 
- [Bands](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Bands "Bands")
- [Darvas Box](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Darvas%20Box "Darvas Box")
- [Ehler's Center of Gravity](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Center%20of%20Gravity "Ehler's Center of Gravity")
- [Ehler's Cycle Period](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Cycle%20Period "Ehler's Cycle Period")
- [Ehler's Detrend](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Detrend "Ehler's Detrend")
- [Ehler's Fractal Adaptive Moving Average](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Fractal%20Adaptive%20Moving%20Average "Ehler's FRAMA")
- [Ehler's Hilbert Transform](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Hilbert%20Transform "Ehler's Hilbert Transform")
- [Ehler's Instantaneous Trendline](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Instantaneous%20Trendline "Ehler's Instantaneous Trendline")
- [Ehler's Sinewave](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Sinewave "Ehler's Sinewave")
- [Ehler's Smooth](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20Smooth "Ehler's Smooth")
- [Ehler's SNR](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ehlers%20SNR "Ehler's SNR")
- [eKamWhere](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/eKamWhere "eKamWhere")
- [eKamPowerRSI](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/eKamPowerRSI "eKamPowerRSI")
- [Gann Swing](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Gann%20Swing "Gann Swing")
- [High Low Oscillator](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/High%20Low%20Oscillator "High Low Oscillator")
- [Hull Moving Average](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Hull%20Moving%20Average "Hull Moving Average")
- [Hurst Channel](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Hurst%20Channel "Hurst Channel")
- [Ichimoku](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Ichimoku "Ichimoku")
- [Jacob Singer's Strategies For Daytrading](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Jacob%20Singer's%20Strategies%20For%20Daytrading "Jacob Singer's Strategies For Daytrading")
- [Kaufman Adaptive Moving Average](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Kaufman%20Adaptive%20Moving%20Average "Kaufman Adaptive Moving Average")
- [Kase Peak Oscillator](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Kase%20Peak%20Oscillator "Kase Peak Oscillator")
- [Laguerre Filter](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Laguerre%20Filter%201%20%26%202 "Laguerre Filter 1 & 2")
- [MATrendline](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/MATrendline "MATrendline")
- [Mesa Phase 1 & 2](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Mesa%20Phase%201%20%26%202 "Mesa Phase 1 & 2")
- [Msheiner Scalping Support & Resistance Lines](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/Msheiner%20Scalping%20Support%20%26%20Resistance%20Lines "Msheiner Scalping Support & Resistance Lines")
- [SafeZone](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/SafeZone "SafeZone")
- [Volume Price Confirmation Indicator (VPCI)](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/VPCI "Volume Price Confirmation Indicator (VPCI)")
- [William's Percent R Histogram](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/W%25R%20Histogram "William's Percent R Histogram")
- [XCAP iPolyFit](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/XCAP%20iPolyFit "XCAP iPolyFit")
- [ZigZag One & Two](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Indicators/ZigZag%20One%20%26%20Two "ZigZag One & Two")

## Optimizers ##
- [Equity Curve STD](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Optimizations/Equity%20Curve%20STD "Equity Curve STD")
- [NP / GP Ratio](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Optimizations/NP-GP-ratio "NP / GP Ratio")
- [Van Tharp Expectancy](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Optimizations/Van%20Tharp%20Expectancy "Van Tharp Expectancy")

## Signals & Strategies ##
- [Donchain System](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/Donchain%20System "Donchain System")
- [GD Exit Suite](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/GD-exit-suite "GD Exit Suite")
- [MA & Std Stops](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/MA%20%26%20Std%20Stops "MA & Std Stops")
- [METS Exits](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/METS%20Exits "METS Exits")
- [NMP System](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/NMP%20System "NMP System")
- [Nija Turtle](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/Nija%20Turtle "Nija Turtle")
- [Stop Targets](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/Stop%20Targets "Stop Targets")
- [Triple Exponential Moving Average Displaced Exit](https://github.com/mtompkins/openAlgo/tree/master/MultiCharts/Signals%20%26%20Strategies/Triple%20XMA%20Displaced%20Exit "Triple Exponential Moving Average Displaced Exit")