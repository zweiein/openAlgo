# Matlab Repository #
This section contains files coded for use with Matlab, primarily in Matlab psuedocode. Code is written so that it should be compiled or MEX'd as Matlab refers to it. In addition, some functions are better implemented in C++ for explicit use with Matlab. These files reside within the Matlab section as opposed to the larger and generic C++ section.

## Notes ##
- Within the ../MEX/Cpp subfolder are files with two primary extensions, `.c` and `.cpp`. These files are **C** and **C++** respectively. As a general statement, Matlab is more **C** friendly derived from its evolution from Fortran as a codebase. Files in the MEX subsection should be compiled directly within Matlab using the `mex` command.
- The large majority of files within the Matlab section are also coded so as to be compiled by use of making a **project** within Matlab and then invoking the compiler. These files make use of the command:
    	coder.extrinsic(function1, function2, ...)
If a given function has this line within its code said function is designed and intended to be *mex'd*.

Revision: 5780.25390
