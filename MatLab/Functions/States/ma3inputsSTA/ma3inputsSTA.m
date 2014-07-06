function [STA,LEAD,MED,LAG] = ma3inputsSTA(price,F,M,S,type)
%MA3INPUTSSTA returns a logical STATE for a fast/medium/slow average calculation
%   ma3inputsSTA returns a logical STATE for a fast/medium/slow 
%   moving-average technical indicator.
%
%   STA = MA3INPUTSSTA(PRICE, F, M, S, type) returns a STATE based upon provided
%   fast (F), medium (M), and slow (S) periods.
%
%   INPUTS:     price = an array of any [C] or [O | C] or [O | H | L | C]
%               F = fast period
%               M = medium period
%               S = slow period
%               type = Available average types are:
%                           -5  Triangle (Double smoothed similar to Hull)
%                           -4  Trimmed
%                           -3  Harmonic
%                           -2  Geometric
%                           -1	Exponential
%                            0  Simple
%                          > 0  Weighted e.g. 0.5 Square root weighted, 1 = linear, 2 = square weighted
%
%   OUTPUT:
%       STA values are LEAD referenced where:
%           1    LEAD > MEDIUM > LAG
%           0    LEAD >= MEDIUM <= LAG
%           0    LEAD <= MEDIUM >= LAG
%          -1    LEAD < MEDIUM < LAG
%
%       LEAD    The moving average value based on the LEAD lookback. 
%               Values prior to the LEAD start are returned as the fClose value
%       MED     The moving average value based on the MED lookback. 
%               Values prior to the MED start are returned as the fClose value
%       LAG     The moving average value based on the LAG lookback. 
%               Values prior to the LAG start are returned as the fClose value
%
%   NOTE:
%       As this file is designed to be MEX'd all inputs are required.
%
% See also movavg, sharpe, macd, tsmovavg

%% MEX code to be skipped
coder.extrinsic('movAvg_mex','OHLCSplitter')

%% Assign correct column to close price
% Check to ensure we have both Open and Close.  If not assume Close only.
% Preallocate so we can MEX
rows = size(price,1);
fOpen = zeros(rows,1);                                      %#ok<NASGU>
fClose = zeros(rows,1);                                     %#ok<NASGU>
fClose = OHLCSplitter(price);

%% Input with error check
if (F > M)
    error('METS:ma3inputsSTA:invalidInputs', ...
        'FAST input > MEDIUM input. Catch this before submitting to ''ma3inputsSIG''');
end; %if

if (M > S)
    error('METS:ma3inputsSTA:invalidInputs', ...
        'MEDIUM input > SLOW input. Catch this before submitting to ''ma3inputsSIG''');
end; %if

if (F > S)
    error('METS:ma3inputsSTA:invalidInputs', ...
        'FAST input > SLOW input. Catch this before submitting to ''ma3inputsSIG''');
end; %if

if F > rows || M > rows || S > rows
    error ('METS:ma3inputsSTA:invalidInputs', ...
        'Lookback is greater than the number of observations (%d)',rows);
end; %if

%% Calculations
% Preallocation
% The following preallocations allow MEX to compile
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/306824
STA = zeros(rows,1);
LEAD = zeros(rows,1);             	%#ok<NASGU>
MED = zeros(rows,1);             	%#ok<NASGU>
LAG = zeros(rows,1);                %#ok<NASGU>

[LEAD,MED] = movAvg_mex(fClose,F,M,type);       % Consider creating an elemental to handle 3 inputs to reduce calls
[~,LAG] = movAvg_mex(fClose,M,S,type);          % MED is captured above

STA((LEAD > MED) & (MED > LAG)) = 1;
STA((LEAD < MED) & (MED < LAG)) = -1;

% Clear erroneous states calculated prior to enough data
STA(1:S-1) = 0;

% Correct calculations prior to enough bars for lead & lag
for ii = 1:S-1
    if (ii < F)
        LEAD(ii) = fClose(ii);          % Reset the moving average calculation to equal the Close
    end;
    if (ii < M)
        MED(ii) = fClose(ii);           % Reset the moving average calculation to equal the Close
    end;
    LAG(ii) = fClose(ii);               % Also reset the slower average
end; %for

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
%   Revision:      5295.16422
%   Copyright:     (c)2014
%


