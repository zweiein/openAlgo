function [SIG,R,SH] = ma3inputs_wprSIG(price,F,M,S,type,wOB,wOS,wPeriod,bigPoint,cost,scaling)
%MA3INPUTSSIG returns a trading signal for a fast/medium/slow average indicator
%   ma3inputsSIG returns a trading signal derived from 'ma3inputsSTA'
%
%   STA = MA3INPUTSSTA(PRICE, F, M, S, type) returns a STATE based upon provided
%   fast(F), medium(M), and slow(S) periods.
%
%   INPUTS:     price       an array of any [C] or [O | C] or [O | H | L | C]
%               F           fast period
%               M           medium period
%               S           slow period
%               type        Available average types are:
%                           -5  Triangle (Double smoothed similar to Hull)
%                           -4  Trimmed
%                           -3  Harmonic
%                           -2  Geometric
%                           -1	Exponential
%                            0  Simple
%                          > 0  Weighted e.g. 0.5 Square root weighted, 1 = linear, 2 = square weighted
%               wOB         Williams Percent R Overbought Level (Default: -30)
%               wOS         Williams Percent R OverSold Level (Dafault: -70)
%               wPeriod     Williams Percent R lookback window (function: willpctr)
%               scaling     sharpe ratio adjuster
%               cost        commission cost for P&L calculation per round turn
%               bigPoint    value of a full tick for P&L calculation
%
%   OUTPUTS:
%               SIG        -1.5 LEAD crossed below LAG.  Sell 1 lot short (reverse if necessary)
%                            0  no action
%                           1.5 LEAD crossed above LAG.  Buy 1 lot long (reverse if necessary)
%                 R         Absolute return
%                SH         Sharpe ratio calculated using R
%
%   NOTES:
%               As this file is designed to be MEX'd all inputs are required.
%               WPR works with negative values in a range from 0 to -100;
%               OverBought = 0 to -30
%               OverSold = -70 to -100
%
%               For a graphical result or variable inputs see 'ma3inputs_wprSIG_DIS.m'
%
% See also movavg, sharpe, macd, tsmovavg, ma3inputsSTA, ma3inputsSIG_DIS, willpctr

%% MEX code to be skipped
coder.extrinsic('OHLCSplitter','willpctr','remEchos_mex','calcProfitLoss','sharpe','ma3inputsSTA_mex','wprSTA_mex')

% Preallocate so we can MEX
rows = size(price,1);
fOpen = zeros(rows,1);                                      %#ok<NASGU>
fClose = zeros(rows,1);                                     %#ok<NASGU>
staMA = zeros(rows,1);                                      %#ok<NASGU>
staWPR = zeros(rows,1);                                     %#ok<NASGU>
SIG = zeros(rows,1);                                        %#ok<NASGU>       

if size(price,2) == 4
    [fOpen,fClose] = OHLCSplitter(price);
else
    error('wprMETS:InputArg',...
        'We need as input O | H | L | C');
end; %if

%% Error check
if (F > M)
    error('METS:ma3inputs_wprSIG:invalidInputs', ...
        'LEAD input > MEDIUM input. Catch this before submitting to ''ma3inputs_wprSIG''');
end; %if

if (M > S)
    error('METS:ma3inputs_wprSIG:invalidInputs', ...
        'MEDIUM input > LAG input. Catch this before submitting to ''ma3inputs_wprSIG''');
end; %if

if (F > rows) || (M > rows) || (S > rows)
    error ('METS:ma3inputs_wprSIG:invalidInputs', ...
        'Lookback is greater than the number of observations (%d)',rows);
end; %if

%% Calculations
% Get state
staMA = ma3inputsSTA_mex(fClose,F,M,S,type);

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

%% Drop any repeats for PNL
SIG = remEchos_mex(SIG);

%% Make sure we have at least one trade first
if ~isempty(find(SIG,1))
    [~,~,~,R] = calcProfitLoss([fOpen fClose],SIG,bigPoint,cost);
    SH = scaling * sharpe(R,0);
else
    % No signal so no return or sharpe.
    R = 0;
    SH = 0;
end; %if

%%
%   -------------------------------------------------------------------------
%                                  _    _ 
%         ___  _ __   ___ _ __    / \  | | __ _  ___   ___  _ __ __ _ 
%        / _ \| '_ \ / _ \ '_ \  / _ \ | |/ _` |/ _ \ / _ \| '__/ _` |
%       | (_) | |_) |  __/ | | |/ ___ \| | (_| | (_) | (_) | | | (_| |
%        \___/| .__/ \___|_| |_/_/   \_\_|\__, |\___(_)___/|_|  \__, |
%             |_|                         |___/                 |___/
%   -------------------------------------------------------------------------
%        This code is distributed in the hope that it will be useful,
%
%                      	   WITHOUT ANY WARRANTY
%
%                  WITHOUT CLAIM AS TO MERCHANTABILITY
%
%                  OR FITNESS FOR A PARTICULAR PURPOSE
%
%                          expressed or implied.
%
%   Use of this code, pseudocode, algorithmic or trading logic contained
%   herein, whether sound or faulty for any purpose is the sole
%   responsibility of the USER. Any such use of these algorithms, coding
%   logic or concepts in whole or in part carry no covenant of correctness
%   or recommended usage from the AUTHOR or any of the possible
%   contributors listed or unlisted, known or unknown.
%
%   Any reference of this code or to this code including any variants from
%   this code, or any other credits due this AUTHOR from this code shall be
%   clearly and unambiguously cited and evident during any use, whether in
%   whole or in part.
%
%   The public sharing of this code does not relinquish, reduce, restrict or
%   encumber any rights the AUTHOR has in respect to claims of intellectual
%   property.
%
%   IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY
%   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
%   OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
%   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
%   STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
%   ANY WAY OUT OF THE USE OF THIS SOFTWARE, CODE, OR CODE FRAGMENT(S), EVEN
%   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
%   -------------------------------------------------------------------------
%
%                             ALL RIGHTS RESERVED
%
%   -------------------------------------------------------------------------
%
%   Author:        Mark Tompkins
%   Revision:      5310.28782
%   Copyright:     (c)2014
%