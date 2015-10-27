%% Bollinger Band Parametric Sweep
%
%	This script runs a parametric sweep using bollBandSIG
%	Parameters: period  Lookback period for calculating the Midline and standard deviation
%	maType	Available average types are:
%	-5 Triangle (Double smoothed similar to Hull)
%	-4 Trimmed  (10%)
%	-3 Harmonic
%	-2 Geometric
%	-1 Exponential
%	 0 Simple
%	>0 Weighted e.g. 0.5 Square root weighted, 1 = linear, 2 = square weighted
%	devUp | devDwn  Number of standard deviations to +/- from the midline
%

%% Parameter sweep settings
% Set cluster
%	0  -  none
%	1  -  6		local
%	>  6		Core

clust = 4;

%% Initialize variables
%%%%%%%%%%%%%%%%%%%%%%%%%
%	Variables	%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Bollinger Band
pStart = 1; pEnd = 100; maType = 0; devUp = 1; devDwn = 1;
period = pStart:pEnd;

%% Select datafile and time adjustment(s)
%	KC1D  (KC)	Arabica Futures	Daily	all years
%	KC1D5 (KC)	Arabica Futures	Daily	5 years
%	KC1M  (KC)	Arabica Futures	1 min	1 year
%	KC5S  (KC)	Arabica Futures	5 sec	6 mos
%	KC5SV (KC)	Arabica Futures	5 sec	6 mos	Validation Set
%	ES5S  (ES)	E-Mini S&P	5 sec	6 mos
%	ES5SV (ES)	E-Mini S&P	5 sec	6 mos	Validation Set
%	ES1M  (ES)	E-Mini S&P	1 min	all years
%	ES1M1 (ES)	E-Mini S&P	1 min	1 year
%	ES1M3 (ES)	E-Mini S&P	1 min	3 year
%
%  Variable to create virtual bars.  Use for small period data series
%	5 second conversions:	1 min = 12,	2 min = 24,	3 min = 36,	4 min = 48,	
%	5 second conversions:	5 min = 60,	50 secs = 10,	45 secs = 9,	40 secs = 8,	
%				30 secs = 6,	20 secs = 4,	15 secs = 3,	10 secs = 2
contract = 'ES1M1';

% Enter either [time] or [startTime endTime]
time = [4];                                                                                        %#ok<NBRAK> 

%% Load Data
[dFile, defFile, scaling] = dataSelect(contract);
data = importFromTxt(dFile);
importSymbolDef(defFile);

%% Cost basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Commissions & Fees	%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
cost=5; % $5 Round turn commission

%% Confirm cluster is active
% Ensure cluster is set to correct config
if matlabpool('size') ~= clust
	warning('Cluster being configured or closed as needed.  Adjusting...');
    
	if matlabpool('size') ~= 0
		matlabpool CLOSE;
	end;
    
	if clust > 1 && clust < 7
		matlabpool('local',clust);
	else
		matlabpool('Core',clust);
	end; %if

end; %if

%% Transform variables to vector
%%%%%%%%%%%%%%%%%%%%%%%%%
%	Vectorize	%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Parallel
% Create a range variable so we can vectorize inputs for parametric sweep
range = {period, maType, devUp, devDwn};

%% Perform the parameter sweep

fprintf('\n\n *** BEGIN PARAMETRIC SWEEP ***\n');
disp('.....................');
startTime = datestr(now);
disp(startTime);
disp('.....................');

%% Annual scaling reset value
inScaling = scaling;

%% Variable to create virtual bars.  Use for small period data series
% parse 'time' variable
if numel(time) == 1
	tStart = time;
	tEnd = time;
elseif numel(time) == 2
	tStart = time(1);
	tEnd = time(2);
else
	error('Unable to parse ''time'' variable.  Aborting...');
end; %if

for t=tStart:tEnd
	% Using a variable for parametric sweep range end so that we can automatically extend it if the
	% optimization finds the boundary value to be the best fit.
    
	% Reinitialize start time
	startTime = datestr(now);
    
	fprintf('Now processing vBar of %d\n',t);
	if t==1
		vBars = data;
	else
		vBars = virtualBars_mex(data,t);
		scaling = inScaling / t;
	end %if
    
	%% Break up vBars into 80% test and 20% validation sets
	testPts = floor(0.8*length(vBars));
	vBarsTest = vBars(1:testPts,:);
	vBarsVal = vBars(testPts+1:end,:);
    
	%% Define parallel function for parametric sweep
	% Ordinarily we would pass a Test set then review a Validation set
	% The parallel function marsiPARMETS sweeps for the best METSharpe and need the full data set.
	% METSharpe is a weighted version of the classic sharpe ratio that looks at both a Test data set result
	% and a validation set result and scores them with their weighted average.
	% Because of this we will not pass a vBarsTest, but will pass the entire data set.
	fun = @(x) bollBandPARMETS(x,vBars,bigPoint,cost,scaling);
    
	%% Sweep for best METSharpe
	%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%          SWEEP          %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Provide a bit of feedback for the user
	optInfo(1, range);
	tic
	[maxSharpe,param,sh,var] = parameterSweep(fun,range);
	toc
    
	endTime = datestr(now);
    
	[~,R,SH] = bollBandSIG_mex(vBars,param(1),param(2),param(3),param(4),...
			bigPoint,cost,scaling);
    
	%% Disply results to command window
	fprintf('Optimization completed: ');
	fprintf(endTime);
	fprintf('\n\nParametric sweep found the following optimized values sweeping for METSharpe: \n');
	fprintf('     Bars In Test Set: %s\n',thousandSep(length(vBars)));
	formatSpec = '     Period: %d     MA type: %d\n   Num STD Up: %.2f   Num STD Dwn: %.2f\n\n';
	fprintf(formatSpec,param(1),param(2),param(3),param(4));
	fprintf('Bollinger Band Sharpe Ratio = %s\r\n',num2str(SH,3));
	fprintf('Cumulative Return = %s\r\n\r\n',thousandSepCash(sum(R)));
    
	bollBandSIG_DIS(vBars,param(1),param(2),param(3),param(4),...
		bigPoint,cost,scaling);
    
	set(gcf,'name','Parameter Result - Entire Data Set')
	snapnow;
    
	fprintf('\n                    -- Iteration Complete --\n\n\n');
    
	%% Export optimization into simple text file
	disp('Now exporting current run into text file log');
	if ~exist('\\SHARE\Matlab\OutputLogs\bollBand Parametric Sweep Results.txt','file')
		fid = fopen('\\SHARE\Matlab\OutputLogs\bollBand Parametric Sweep Results.txt','w');
	else
		fid = fopen('\\SHARE\Matlab\OutputLogs\bollBand Parametric Sweep Results.txt','a');
	end; %if
    
	% Get the number of iterations we processed
	strNumI = thousandSep(numIterations(range));
    
	fprintf(fid,'\r\n\r\n*** BEGIN PARAMETRIC SWEEP ***\r\n');
	fprintf(fid,'Data file: %s\r\n',dFile);
	fprintf(fid,'Start Time %s\r\n',startTime);
	fprintf(fid,'\r\nNow processing vBar of %d\r\n',t);
	formatSpec = '\r\nOptimization range(s):\r\n';
	fprintf(fid,formatSpec);
	for ii = 1:length(range)
		if isempty(range{ii})
			formatSpec = '          Parameter %d: Not Given\r\n';
			fprintf(formatSpec,ii)
		else
			formatSpec = '          Parameter %d: %s\r\n';
			fprintf(fid,formatSpec,ii,vect2colon(range{ii}));
		end;
	end;
    
	formatSpec = '\r\nNumber of iterations performed: %s\r\n\r\n';
	fprintf(fid,formatSpec,strNumI);
    
	fprintf(fid,'\r\nParametric sweep found the following optimized values sweeping for METSharpe: \r\n');
	fprintf(fid,'     Bars In Test Set: %s\r\n',thousandSep(length(vBars)));
	formatSpec = '     Period: %d     MA type: %d\n   Num STD Up: %.2f   Num STD Dwn: %.2f\n\n';
	fprintf(fid,formatSpec,param(1),param(2),param(3),param(4));
    
	fprintf(fid,'Bollinger Band Sharpe Ratio = %s\r\n',num2str(SH,3));
	fprintf(fid,'Cumulative Return = %s\r\n\r\n',thousandSepCash(sum(R)));
    
	fprintf(fid,'End Time %s\r\n',endTime);
	fprintf(fid,'*** END PARAMETRIC SWEEP ***\r\n');
	fclose(fid);
	fprintf(' **** JOB COMPLETE ****\n');
end; %for

%% END SCRIPT

%
%  -------------------------------------------------------------------------
%
%	 ██████╗ ██████╗ ███████╗███╗   ██╗ █████╗ ██╗      ██████╗  ██████╗ 
%	██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔══██╗██║     ██╔════╝ ██╔═══██╗
%	██║   ██║██████╔╝█████╗  ██╔██╗ ██║███████║██║     ██║  ███╗██║   ██║
%	██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██╔══██║██║     ██║   ██║██║   ██║
%	╚██████╔╝██║     ███████╗██║ ╚████║██║  ██║███████╗╚██████╔╝╚██████╔╝
%	 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝
%   
%  -------------------------------------------------------------------------
%        This code is distributed in the hope that it will be useful,
%
%                      	 WITHOUT ANY WARRANTY
%
%                  WITHOUT CLAIM AS TO MERCHANTABILITY
%
%                  OR FITNESS FOR A PARTICULAR PURPOSE
%
%                           expressed or implied.
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
%   Author:	Mark Tompkins
%   Revision:	
%   Copyright:	(c)2015
