# Ehler's Detrend #
## Indicator description: ##
This function is a revised version of the code from "Optimal Detrending", by John F. Ehlers in the July, 2000 issue of TASC. This version replaces the calculated median price with a "Price" input and makes the lookback period an input parameter for more generality.
		
It also creates declared variables instead of using Value1 and Value2 in order that they can be properly initialized. These are then initialized to the proper values to eliminate the long initialization time of the original code in the article. 

![Screenshot](/../master/ScreenShots/EhlersDetrend_Ind.jpg?raw=true "Ehler's Detrend")
