/************************************ **Van Tharp Expectancy formula **********************

MultiCharts Custom Criteria: Van Tharp expectancy and SQN. Created for optimise function in MC, testing fine on MC 9.0
`(PW*AW)-(PL*AL)` generates expectancy, further `(PW*AW)-(PL*AL)/stddev` would derive SQN. However I am only looking at expectancy in this formula.

This iteration uses `StrategyPerformance.NetProfit / StrategyPerformance.TotalTrades` instead of `StrategyPerformance.TotalTrades`, as this is how MC calculates
average winning trade. Even though they use LosingTrades to calculate the avergae loser.
