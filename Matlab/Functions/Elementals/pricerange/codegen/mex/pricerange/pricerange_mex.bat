@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2013a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2013a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=pricerange_mex
set MEX_NAME=pricerange_mex
set MEX_EXT=.mexw64
call mexopts.bat
echo # Make settings for pricerange > pricerange_mex.mki
echo COMPILER=%COMPILER%>> pricerange_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> pricerange_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> pricerange_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> pricerange_mex.mki
echo LINKER=%LINKER%>> pricerange_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> pricerange_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> pricerange_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> pricerange_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> pricerange_mex.mki
echo BORLAND=%BORLAND%>> pricerange_mex.mki
echo OMPFLAGS= >> pricerange_mex.mki
echo OMPLINKFLAGS= >> pricerange_mex.mki
echo EMC_COMPILER=msvcsdk>> pricerange_mex.mki
echo EMC_CONFIG=optim>> pricerange_mex.mki
"C:\Program Files\MATLAB\R2013a\bin\win64\gmake" -B -f pricerange_mex.mk
