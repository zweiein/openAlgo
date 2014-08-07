/*
 * pricerange_terminate.c
 *
 * Code generation for function 'pricerange_terminate'
 *
 * C source code generated on: Wed Aug 06 09:22:48 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pricerange.h"
#include "pricerange_terminate.h"

/* Function Definitions */
void pricerange_atexit(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void pricerange_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (pricerange_terminate.c) */
