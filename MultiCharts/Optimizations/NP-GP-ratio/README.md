/************************************* **Ratio of net proft to gross profit** ******************************************/

    if (StrategyPerformance.GrossLoss != 0) {
    return StrategyPerformance.NetProfit / StrategyPerformance.GrossProfit;
    }

> This function maximizes the ratio of net profit to gross profit. The higher the net profit is and closer to the gross profit figure, the higher this ratio will be. With .75 meaning you are retaining 75% of profit run up.
