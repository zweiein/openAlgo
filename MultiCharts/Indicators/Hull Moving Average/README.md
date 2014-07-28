# Hull Moving Average #
## Indicator description: ##
The Hull Moving Average solves the age old dilemma of making a moving average more responsive to current price activity whilst maintaining curve smoothness. In fact the HMA almost eliminates lag altogether and manages to improve smoothing at the same time. To understand how it achieves both of these opposing outcomes simultaneously we need to start with an easily understood frame of reference. The following chart contains a 16 week simple moving average which constantly lags the price activity and has poor smoothness.

16 week Simple Moving Average

Firstly, solving the problem of curve smoothing can be done by taking an average of the average, i.e. 16 period SMA (16 period SMA (Price)). The bad news is that it causes a huge increase in lag as seen below.

16 week Nested Simple Moving Average

Solving the problem of lag is a bit more involved and requires an explanation with numbers rather than charts. Consider a series of 10 numbers from ’0′ to ’9′ inclusive and imagine that they are successive price points on a chart with 9 being the most recent price point at the right hand leading edge. If we take the 10 period simple average of these numbers then, not surprisingly, we will determine the midpoint of 4.5 which significantly lags behind the most recent price point of 9. Here’s the clever bit…first let’s halve the period of the average to 5 and apply it to the most recent numbers of 5,6,7,8, and 9, the result being the midpoint of 7.

# | # | # | # | # | - | # | # | # | # | #
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
0 | 1 | 2 | 3 | 4 | - | 5 | 6 | 7 | 8 | 9
- | - | - | - | - | 4.5 | - | - | 7 | - | -


Finally, to remove the lag we take the midpoint of 7 and add the difference between the two averages which equals 2.5 (7 – 4.5). This gives a final answer of 9.5 (7 + 2.5) which is a slight overcompensation. But this overcompensation is very handy because it offsets the lagging effect of the nested averaging. Hence the result of combining these 2 techniques is a near perfect balance between lag reduction and curve smoothing.

![Screenshot](/../master/ScreenShots/HullMovingAverage_Ind.jpg?raw=true "Hull Moving Average")
