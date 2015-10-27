spmd
[status, myHostName] = system('hostname');
assert(status == 0);

% get all worker hostnames as a cell array
allHostNames = gcat({myHostName});

% find first occurrence of my hostname
leadWorkerIndex = find(strcmp(myHostName, allHostNames), 1, 'first');

% Restrict command to the node lead worker
	if labindex == leadWorkerIndex
		!Powercfg -SETACTIVE SCHEME_MIN
	end
end