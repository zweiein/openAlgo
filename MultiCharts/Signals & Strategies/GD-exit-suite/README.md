**# GD exit suite #**

**## Signal description: ##**

Sets exit signals based on a variety of logic

   	PctTrailing("-- Pct Trailing --"), 			// Label
    		Enable_Pct_Trail(1), 				// 0 - Disabled | 1 - Enabled
    		Init_percent_trail$1( 100 ), 		// Figure to begin percent profit capture trail
    		TrailingPct1( 73 ), 				// 1st level percentage drop to close profitable position and retain profit, e.g. 20 closes after max position profit drops by 20%
    		Init_percent_trail$2( 225.00), 		// 2nd level to change pct trail to lower figure
    		TrailingPct2 ( 20 ), 				// Attempt to retain more runup profit, e.g. switch from 70% trail to tighter 20% trail
		
	Dollar_Trailing("-- Dollar trailing --"), 	// Label
		Enable_Dollar_Trail(1),	 				// 0 - Disabled | 1 - Enabled
		Init_dollar_trail1 (187.50), 			// Dollar amount to begin trail stop
		Dollar_trail_amt1 (150.00), 			// 1st dollar amt to trail behind profit
		Init_dollar_trail2 (275.00), 			// Dollar amount to begin trail stop
		Dollar_trail_amt2 (162.50); 			// 2nd lvel dollar amt to trail behind profit
