function [barsOut,sigOut,R,SH] = ma3inputs_wpr_NumTicksPftSIG(price,F,M,S,typeMA,...
                        wOB,wOS,wPeriod,...
                        minTick,numTicks,openAvg,...
                        bigPoint,cost,scaling)
%MA3INPUTS_WPR_NUMTICKSPFTSIG returns a trading signal for a 3 ma system with William's %R filter and achieved profits
%   %ma3inputs_wpr_NumTicksPftSIG returns a trading signal for a 3 ma system with William's %R filter and 
%   achieved profits derived from 'ma3inputsSTA' and 'wprSTA'
%
%   INPUTS:     price       an array of [O | C] or [O | H | L | C]
%               F           fast period
%               M           medium period
%               S           slow period
%               typeMA      Available average types are:
%                           -5  Triangle (Double smoothed similar to Hull)
%                           -4  Trimmed
%                           -3  Harmonic
%                           -2  Geometric
%                           -1	Exponential
%                            0  Simple
%                          > 0  Weighted e.g. 0.5 Square root weighted, 1 = linear, 2 = square weighted
%               wOB         Williams Percent R Overbought Level     (Default: -30)
%               wOS         Williams Percent R OverSold Level       (Default: -70)
%               wPeriod     Williams Percent R lookback window      (Default: 14)
%               scaling     sharpe ratio adjuster
%               cost        commission cost for P&L calculation per round turn
%               bigPoint    value of a full tick for P&L calculation
%
%   OUTPUTS:
%               SIG        -1.5 Sell 1 lot short (reverse if necessary)
%                            0  no action
%                           1.5 Buy 1 lot long (reverse if necessary)
%                 R         Absolute return
%                SH         Sharpe ratio calculated using R
%
%   NOTES:
%               As this file is designed to be MEX'd all inputs are required.
%               WPR works with negative values in a range from 0 to -100;
%               OverBought = 0 to -30
%               OverSold = -70 to -100
%
%               For a graphical result or variable inputs see 'ma3inputs_wpr_NumTicksPftSIG_DIS.m'
%
% See also movavg, sharpe, macd, tsmovavg, ma3inputsSTA, ma3inputsSIG_DIS, willpctr

%% MEX code to be skipped
coder.extrinsic('OHLCSplitter','willpctr','remEchos_mex','calcProfitLoss','sharpe','ma3inputsSTA_mex',...
                'numTicksProfit','wprSTA_mex')

% Preallocate so we can MEX
rows = size(price,1);
staMA = zeros(rows,1);                                      %#ok<NASGU>
staWPR = zeros(rows,1);                                     %#ok<NASGU>
fClose = zeros(rows,1);                                     %#ok<NASGU>
SIG = zeros(rows,1);                                        %#ok<NASGU>      

if size(price,2) == 4
    fClose = OHLCSplitter(price);
else
    error('wprMETS:InputArg',...
        'We need as input O | H | L | C');
end; %if

%% Error check
if (F > M)
    error('METS:ma3inputs_wpr_NumTicksPftSIG:invalidInputs', ...
        'LEAD input > MEDIUM input. Catch this before submitting to ''ma3inputs_wpr_NumTicksPftSIG''');
end; %if

if (M > S)
    error('METS:ma3inputs_wpr_NumTicksPftSIG:invalidInputs', ...
        'MEDIUM input > LAG input. Catch this before submitting to ''ma3inputs_wpr_NumTicksPftSIG''');
end; %if

if (F > rows) || (M > rows) || (S > rows)
    error ('METS:ma3inputs_wpr_NumTicksPftSIG:invalidInputs', ...
        'Lookback is greater than the number of observations (%d)',rows);
end; %if

%% Calculations
% Get state
staMA = ma3inputsSTA_mex(fClose,F,M,S,typeMA);

% Returns ternary state filter where -1 OB, 1 OS, 0 neutral
staWPR = wprSTA_mex(price,wPeriod,[wOB,wOS]);

%% Use WPR as FILTER
% Aggregate the two states
SIG = (staMA + staWPR);
    
% Any instance where the |sum| of the 2 signals is ~= 2 means both conditions are not met
% Drop those instances
SIG(abs(SIG)~=2) = 0;
    
% Refine to a signal
SIG = sign(SIG) * 1.5;

if(~isempty(find(SIG,1)))
    % Clean up repeating information
    SIG = remEchos_mex(SIG);
    
    % Pass generated signal vector to profit taking routine
    [barsOut,sigOut] = numTicksProfit(price,SIG,minTick,numTicks,openAvg);
    
    % Generate PNL
    [~,~,~,R] = calcProfitLoss(barsOut,sigOut,bigPoint,cost);
    
    % Calculate sharpe ratio
    SH=scaling * sharpe(R,0);
else
    barsOut = price;
    sigOut = SIG;
    % No signals - no sharpe.
    SH= 0;
    R=0;
end; %if
