function [STA,WPR] = wprDynSTA(price, Mult, OB, OS)
%WPRDYNSTA returns a logical STATE based on Williams % R with an auto-adjusting dynamic lookback period
%   wprDynSTA returns a logical STATE based on Williams % R with an auto-adjusting dynamic lookback period
%
%
%   INPUTS:     price       	An array of price in the form [O | H | L | C]     
%               Mult            Modifier to control effective risk based on volatility. (Default: 3)
%                               The higher the value of Mult, the LESS risky. 
%                               Values over 33 are illogical
%               OB              threshold of overbought (default: 30)
%               OS              threshold of oversold (default: 70)
%               
%   OUTPUT: 	STA             1	BUY STATE	(WPR > OS)
%                               0	neutral     (OB > WPR < OS)
%                              -1   SELL STATE	(WPR < OB)
%
%   STA = WPRDYNSTA(PRICE)          returns a STATE based upon provided price vector
%   [STA,WPR] = WPRDYNSTA(PRICE)    returns a STATE based upon provided price vector and WPR value
%

% Check input arguments.
switch nargin
    case 1
        Mult = 3;
        OB = 30;       
        OS = 70;
    case 2
        OB = 33 - Mult;       
        OS = 67 + Mult;
    case 3
        error('wprDynSTAinputs:ambiguous',...
            'Cannot interpret 3 inputs. Exiting.');
end

% Preallocate so we can MEX
rows = size(price,1);
STA = zeros(rows,1);
WPR = ones(rows,1) * (3 + Mult * 2);                    %#ok<NASGU>
HighestH = NaN * ones(rows,1);
LowestL = NaN * ones(rows,1);

%% Calculations
% Calculate dynamic lookback periods
ascLookback = ascRange(price, Mult);

% Parse
[~,H,L,C] = OHLCSplitter(price);

% Calculate the Highest High and Lowest Low for each dynamic lookback period
for ii = 2:rows
    if ascLookback(ii,1) >= ii 
        firstBar = 1;
    else
        firstBar = ii - ascLookback(ii,1) + 1;
    end;
    HighestH(ii,1) = max(H(firstBar:ii,1));
    LowestL(ii,1) = min(L(firstBar:ii,1));
end;

% Calculate modified dynamic W%R
WPR = (C - LowestL) ./ (HighestH - LowestL) * 100;
% If data seems 'odd' ensure longest lookback period
WPR(HighestH == LowestL) = (3 + Mult * 2);

% Assign Overbought / Oversold states
STA(WPR < OB) = -1;
STA(WPR > OS) = 1;

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
%   Revision:      5332.11073
%   Copyright:     (c)2014
%

