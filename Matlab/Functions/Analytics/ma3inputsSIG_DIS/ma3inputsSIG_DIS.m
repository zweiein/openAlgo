function varargout = ma3inputsSIG_DIS(price,F,M,S,typeMA,bigPoint,cost,scaling,hSub)
%MA3INPUTSSIG_DIS returns a trading signal for a lead/medium/lag indicator
%   movAvg2inputs returns a trading signal for a lead/medium/lag
%   moving-average technical indicator.
%
%   S = MA3INPUTSSIG_DIS(PRICE) returns a trading signal based upon a 5-period
%   lead, 10-period medium, and a 200-period lag.
%	S is the trading signal of values -1, 0, 1 where -1 denotes
%   a sell (short), 0 is neutral, and 1 is buy (long).
%
%   S = MA3INPUTSSIG_DIS(PRICE,F,M,S) returns a trading signal for a F-period lead,
%   M-period medium, and S-period lag.
%
%   [S,R,SH,LEAD,MEDIUM,LAG] = MA3INPUTSSIG_DIS(...) returns the trading signal S, the
%   absolute return in R, the Sharpe Ratio in SH calcualted using R, and
%   the LEAD, Medium and LAG vector series.
%
%   hSub so that we can return ma3inputs as a subPlot
%

if (nargin == 2) || (nargin == 3)
    error('MA3INPUTSSIG_DIS:NoLagWindowDefined',...
        'When defining lookback windows values for LEAD, MEDIUM, and LAG must all be provided.')
end; %if

%% Process input args
if ~exist('typeMA', 'var'), typeMA = 0; end; %if
if ~exist('scaling','var'), scaling = 1; end; %if
if ~exist('cost', 'var'), cost = 0; end; %if
if ~exist('bigPoint', 'var'), bigPoint = 1; end; %if

if nargin < 2
    % default values - often used in MACD
    F = 5;
    M = 10;
    S = 200;
end %if

rows = size(price,1);

%% Input with error check
if (F > M)
    error('MA3INPUTSSIG_DIS:invalidInputs', ...
        'The LEAD lookback must be less than or equal to the MEDIUM lookback.');
end; %if

if (M > S)
    error('MA3INPUTSSIG_DIS:invalidInputs', ...
        'The MEDIUM lookback must be less than or equal to the LAG lookback.');
end; %if

if F > rows || M > rows || S > rows
    error ('MA3INPUTSSIG_DIS:invalidInputs', ...
        'Lookback is greater than the number of observations (%d)',rows);
end; %if

[fOpen,fClose] = OHLCSplitter(price);
returns = zeros(rows,1);
SIG = zeros(rows,1);

%% Simple lead/lag calculation
% Get state
[STA, LEAD, MED, LAG] = ma3inputsSTA_mex(fClose,F,M,S,typeMA);

% Convert state to signal
SIG(STA < 0) = -1.5;
SIG(STA > 0) =  1.5;

% Clear erroneous signals calculated prior to enough data
SIG(1:S-1) = 0;

if(~isempty(find(SIG,1)))
    % Clean up repeating information for PNL
    SIG = remEchos_mex(SIG);
    
    % Generate PNL
    [~,~,~,returns] = calcProfitLoss([fOpen fClose],SIG,bigPoint,cost);

    % Calculate sharpe ratio
    sharpeRatio = scaling*sharpe(returns,0);
else
    % No signals - no sharpe.
    sharpeRatio = 0;
end; %if

% Correct calculations prior to enough bars for lead & lag
for ii = 1:S-1
    if (ii < F)
        LEAD(ii) = fClose(ii);          	% Reset the moving average calculation to equal the Close
    end;
    if (ii < M)
        MED(ii) = fClose(ii);               % Reset the moving average calculation to equal the Close
    end;
    LAG(ii) = fClose(ii);                   % Also reset the slower average
end; %for

%% If no assignment to variable, show the averages in a chart
if (nargout == 0) && (~exist('hSub','var'))% Plot
	% Center plot window basis monitor (single monitor calculation)
    scrsz = get(0,'ScreenSize');
    figure('Position',[scrsz(3)*.15 scrsz(4)*.15 scrsz(3)*.7 scrsz(4)*.7])
    
    % Plot results
    ax(1) = subplot(2,1,1);
    plot([fClose,LEAD,MED,LAG]);
    axis (ax(1),'tight');
    grid on
    legend('Close',['Lead ',num2str(F)],['Med ',num2str(M)],['Lag ',num2str(S)],'Location','NorthWest')
    title(['F/M/S MA Results, Annual Sharpe Ratio = ',num2str(sharpeRatio,3)])
    
    ax(2) = subplot(2,1,2);
    plot([SIG,cumsum(returns)]); grid on
    legend('Position','Cumulative Return','Location','North')
    title(['Final Return = ',thousandSepCash(sum(returns))])
    linkaxes(ax,'x')
    
elseif (nargout == 0) && exist('hSub','var')% Plot as subplot
    % We pass hSub as a string so we can have asymmetrical graphs
    % The call to char() parses the passed cell array
    ax(1) = subplot(str2num(char(hSub(1))), str2num(char(hSub(2))), str2num(char(hSub(3)))); %#ok<ST2NM>
    plot([fClose,LEAD,MED,LAG]);
    axis (ax(1),'tight');
    grid on
    legend('Close',['Lead ',num2str(F)],['Med ',num2str(M)],['Lag ',num2str(S)],'Location','NorthWest')
    title(['F/M/S MA Results, Annual Sharpe Ratio = ',num2str(sharpeRatio,3)])
    set(gca,'xticklabel',{})
    
    ax(2) = subplot(str2num(char(hSub(1))),str2num(char(hSub(2))), str2num(char(hSub(4)))); %#ok<ST2NM>
    plot([SIG,cumsum(returns)]); grid on
    legend('Position','Cumulative Return','Location','North')
    title(['Final Return = ',thousandSepCash(sum(returns))])
    linkaxes(ax,'x')
    
else
    for ii = 1:nargout
        switch ii
            case 1
                varargout{1} = SIG;
            case 2
                varargout{2} = returns;
            case 3
                varargout{3} = sharpeRatio;
            case 4
                varargout{4} = LEAD;
            case 5
                varargout{5} = MED;
            case 6
                varargout{6} = LAG;
            otherwise
                warning('MOVAVG2INPUTS:OutputArg','Too many output arguments requested, ignoring last ones');
        end %switch
    end %for
end %if

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
%   Revision:      5295.18512
%   Copyright:     (c)2014
%

