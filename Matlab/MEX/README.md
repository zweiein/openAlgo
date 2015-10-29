# MEX #
While the repository may have files already MEX'd, it is strongly recommended that you compile your own files directly. This will reduce the ambiguity in respect to environment.

Mathwork's reference to MEX'ing:
[http://bit.ly/141doGh](http://bit.ly/141doGh)

Mathwork's reference to debugging a MEX file:
[http://bit.ly/18zBn2T](http://bit.ly/18zBn2T)

## Notes ##

- When debugging MEX files with Visual Studio, MEX debug symbols are loaded dynamically. This may cause an indication within the VS IDE that a breakpoint will not be hit. This often proves to be incorrect.
- There are dependencies between certain MEX files such that within a given MEX'd compilation an external function (or library) may be referenced. Using [numTicksProfit](https://github.com/mtompkins/openAlgo/tree/master/Matlab/MEX/C%2B%2B/numTicksProfit "numTicksProfit") as an example, this routine relies on trivial functions that are located within [*myMath.cpp*](https://github.com/mtompkins/openAlgo/tree/master/C%2B%2B/myFunctions "myMath.cpp").  The MEX command within Matlab then has the following form to include the external referenced file:

    `mex numTicksProfit.cpp -g G:\openAlgo\C++\myFunctions\myMath.cpp -IG:\openAlgo\C++\myFunctions`

	where '-IG:\openAlgo\...' is '*dash EYE somePath*' to indicate an Include as per Matlab documentation. Also shown is the '-g' option to create a symbol file for debugging.

Revision: 5780.25390
