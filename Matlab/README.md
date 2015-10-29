# Matlab Repository #
This section will contain files coded for use with Matlab, primarily in Matlab psuedocode. Where possible and appropriate, code is written so that it should be compiled (or MEX'd as Matlab refers to it). In addition, some functions are better implemented in C++ for explicit use with Matlab. These files reside  within the Matlab section as opposed to the larger and generic C++ section.

## Notes ##
- Within the ../MEX/C++ subfolder are files with two primary extensions, *.c* and *.cpp*. These files are *C* and *C++* respectively. As a general statement, Matlab is more *C* friendly than *C++* which is a byproduct of its evolution from Fortran to *C* as a codebase. There is little need at this time to bifurcate the Matlab subsection in this regard. Files in the MEX subsection should be compiled directly within Matlab using the *mex* command.
- The large majority of files within the Matlab section are also coded so as to be *mex'd* by use of making a *project* within Matlab and then invoking the Matlab compiler. These files make use of the command:


    	coder.extrinsic(function1, function2, ...)
If a given function has this line within its code said function is designed and intended to be *mex'd*.

Revision: 5780.25390
