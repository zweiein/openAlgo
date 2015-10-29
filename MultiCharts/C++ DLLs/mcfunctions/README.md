# MultiCharts DLL functions #

## Conventions used for functions ##
The below list of functions are exposed in the DLL project and can be called from MultiCharts as follows (psuedo) in PowerLanguage:

    external method: "C:\Path\To\Compiled\DLL\MCFunctions.dll", double, "SomeFunc",
						int {DataStream}, varType {someParameter}, ...;

where *varType* is the explicitly identified input variable type (e.g. int, double, ...);

- *iDataStream* is a passed integer of the data stream to use (e.g. 0 = Data1, 1 = Data2, ...)
- *Len* is a passed integer length of the lookback period where necessary (e.g. 9 = nine bars)
- *BarNum* is a passed integer bar reference where 0 is current bar and *n* is *n*-bars ago (i.e. someFunc[*n*])


## Average Range ##
    double AvgRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## Highest Close ##
    double HCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## Highest High ##
    double HHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## Lowest Close ##
    double LCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## Lowest Low ##
    double LLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## Simple Moving Average ##
    double MovAvgFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## William's Percent R ##
    double PercentR_Func(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
## True High ##
    double TrueHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);
## True Low ##
    double TrueLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);
## True Range ##
    double TrueRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);

Revision: 5780.25390
