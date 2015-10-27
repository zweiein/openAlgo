#import "D:\Program Files\TS Support\MultiCharts64\PLKit.dll" no_namespace
#include "MCFunctions.h"
#include <cmath>   

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	NOTE:	Although the TradeStation SDK documentation has shown that it is acceptible to use a 
//			calculation when referencing 'barsback' (e.g. pELOBj->HighMD[iDataStream]->AsDouble[i + 3]) 
//			such that in this example the 'barsback' calculation is 'i + 3', testing has shown that at 
//			least with the MultiCharts implementation this method causes inconsistent results. 
//			To overcome this, the coding practice is to calculate the 'barsback' reference with 
//			a varable first, then pass the variable in the method.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Prototyping
double __stdcall AvgRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall HCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall HHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall LCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall LLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall MovAvgFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall PercentR_Func(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum);
double __stdcall TrueHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);
double __stdcall TrueLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);
double __stdcall TrueRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum);

double __stdcall AvgRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	double dAvgRng = 0;

	if (Len > 0)
	{
		int lookback = Len;
		int barNum = pELObj->CurrentBar[iDataStream];
		int barRef = 0;

		if (barNum == 1) return pELObj->HighMD[iDataStream]->AsDouble[0] - pELObj->LowMD[iDataStream]->AsDouble[0];
		if (barNum < Len) lookback = barNum;

		double dSum = 0.0;
		for (int i = 0; i < lookback; i++)
		{
			barRef = i + BarNum;
			dSum += (pELObj->HighMD[iDataStream]->AsDouble[barRef] - pELObj->LowMD[iDataStream]->AsDouble[barRef]);
		}

		dAvgRng = dSum / lookback;

	}

	return dAvgRng;
}

double __stdcall HCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	if (Len > 0)
	{
		int barNum = pELObj->CurrentBar[iDataStream];
		if (barNum == 1) return pELObj->CloseMD[iDataStream]->AsDouble[0];
		if (barNum < (Len + BarNum)) Len = barNum;

		double dClose = pELObj->CloseMD[iDataStream]->AsDouble[BarNum];
		int barRef = 0;
		for (int i = 0; i < Len; i++)
		{
			barRef = i + BarNum;
			dClose = max(dClose, pELObj->CloseMD[iDataStream]->AsDouble[barRef]);
		}

		return dClose;
	}

	return -1;
}

double __stdcall HHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	if (Len > 0)
	{
		int barNum = pELObj->CurrentBar[iDataStream];
		if (barNum == 1) return pELObj->HighMD[iDataStream]->AsDouble[0];
		if (barNum < (Len + BarNum)) Len = barNum;

		double dHighest = pELObj->HighMD[iDataStream]->AsDouble[BarNum];
		int barRef = 0;
		for (int i = 0; i < Len; i++)
		{
			barRef = i + BarNum;
			dHighest = max(dHighest, pELObj->HighMD[iDataStream]->AsDouble[barRef]);
		}

		return dHighest;
	}

	return -1;
}

double __stdcall LCloseFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	if (Len > 0)
	{
		int barNum = pELObj->CurrentBar[iDataStream];
		if (barNum == 1) return pELObj->CloseMD[iDataStream]->AsDouble[0];
		if (barNum < (Len + BarNum)) Len = barNum;

		double dClose = pELObj->CloseMD[iDataStream]->AsDouble[BarNum];
		int barRef = 0;
		for (int i = 0; i < Len; i++)
		{
			barRef = i + BarNum;
			dClose = min(dClose, pELObj->CloseMD[iDataStream]->AsDouble[barRef]);
		}

		return dClose;
	}

	return -1;
}

double __stdcall LLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	if (Len > 0)
	{
		int barNum = pELObj->CurrentBar[iDataStream];
		if (barNum == 1) return pELObj->LowMD[iDataStream]->AsDouble[0];
		if (barNum < (Len + BarNum)) Len = barNum;

		double dLow = pELObj->LowMD[iDataStream]->AsDouble[BarNum];
		int barRef = 0;
		for (int i = 0; i < Len; i++)
		{
			barRef = i + BarNum;
			dLow = min(dLow, pELObj->LowMD[iDataStream]->AsDouble[barRef]);
		}

		return dLow;
	}

	return -1;
}

double __stdcall MovAvgFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{

	double dMovAvg = 0;

	if (Len > 0)
	{
		int lookback = Len;
		int barNum = pELObj->CurrentBar[iDataStream];

		if (barNum == 1) return pELObj->CloseMD[iDataStream]->AsDouble[0];
		if (barNum < (Len + BarNum)) lookback = barNum;

		double dSum = 0.0;
		int barRef = 0;
		for (int i = 0; i < lookback; i++)
		{
			barRef = i + BarNum;
			dSum += pELObj->CloseMD[iDataStream]->AsDouble[barRef];
		}
		dMovAvg = dSum / lookback;
	}

	return dMovAvg;

}

double __stdcall PercentR_Func(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int Len, int BarNum)
{
	int barNum = pELObj->CurrentBar[iDataStream];
	if (barNum == 1) return 50;
	if (barNum < (Len + BarNum)) Len = barNum;

	double var1 = HHighFunc(pELObj, iDataStream, Len, BarNum);
	double var2 = var1 - LLowFunc(pELObj, iDataStream, Len, BarNum);

	return var2 != 0 ? 100 - ((var1 - pELObj->CloseMD[iDataStream]->AsDouble[BarNum]) / var2) * 100 : 0;

}

double __stdcall TrueHighFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum)
{
	int barNum = pELObj->CurrentBar[iDataStream];
	int barRef = 1 + BarNum;

	if (barNum == 1 || BarNum >= (barNum - 1)) return pELObj->HighMD[iDataStream]->AsDouble[0];

	return max(pELObj->CloseMD[iDataStream]->AsDouble[barRef], pELObj->HighMD[iDataStream]->AsDouble[BarNum]);
}

double __stdcall TrueLowFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum)
{
	int barNum = pELObj->CurrentBar[iDataStream];
	int barRef = 1 + BarNum;

	if (barNum == 1 || BarNum >= (barNum - 1)) return pELObj->LowMD[iDataStream]->AsDouble[0];

	return min(pELObj->CloseMD[iDataStream]->AsDouble[barRef], pELObj->LowMD[iDataStream]->AsDouble[BarNum]);
}

double __stdcall TrueRangeFunc(IEasyLanguageObject *pELObj, EN_DATA_STREAM iDataStream, int BarNum)
{
	double trH = 0, trL = 0;

	trH = TrueHighFunc(pELObj, iDataStream, BarNum);
	trL = TrueLowFunc(pELObj, iDataStream, BarNum);

	return trH - trL;
}