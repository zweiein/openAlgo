/*
 * pricerange.c
 *
 * Code generation for function 'pricerange'
 *
 * C source code generated on: Wed Aug 06 09:22:48 2014
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "pricerange.h"
#include "pricerange_emxutil.h"

/* Variable Definitions */
static emlrtRTEInfo emlrtRTEI = { 1, 21, "pricerange",
  "G:/openAlgo/MatLab/Functions/Elementals/pricerange/pricerange.m" };

static emlrtRTEInfo b_emlrtRTEI = { 16, 5, "abs",
  "C:/Program Files/MATLAB/R2013a/toolbox/eml/lib/matlab/elfun/abs.m" };

static emlrtECInfo emlrtECI = { -1, 15, 12, "pricerange",
  "G:/openAlgo/MatLab/Functions/Elementals/pricerange/pricerange.m" };

/* Function Definitions */
void pricerange(const emxArray_real_T *price, emxArray_real_T *diff)
{
  emxArray_real_T *x;
  int32_T i0;
  int32_T loop_ub;
  uint32_T unnamed_idx_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&x, 1, &emlrtRTEI, TRUE);

  /* PRICERANGE returns the absolute value difference between two vectors */
  /*  */
  /*    INPUTS:     prices          An array of price in the form [H | L]      */
  /*  */
  /* 	OUTPUTS:	diff			PRICERANGE vector */
  /*  */
  /* 	PRICERANGE(PRICE)			Returns a 1 dimensional vector of the 'pricerange.m' function. */
  /* if */
  i0 = price->size[0];
  loop_ub = price->size[0];
  emlrtSizeEqCheck1DFastR2012b(i0, loop_ub, &emlrtECI, emlrtRootTLSGlobal);
  loop_ub = price->size[0];
  i0 = x->size[0];
  x->size[0] = loop_ub;
  emxEnsureCapacity((emxArray__common *)x, i0, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  for (i0 = 0; i0 < loop_ub; i0++) {
    x->data[i0] = price->data[i0] - price->data[i0 + price->size[0]];
  }

  unnamed_idx_0 = (uint32_T)x->size[0];
  i0 = diff->size[0];
  diff->size[0] = (int32_T)unnamed_idx_0;
  emxEnsureCapacity((emxArray__common *)diff, i0, (int32_T)sizeof(real_T),
                    &b_emlrtRTEI);
  for (loop_ub = 0; loop_ub < x->size[0]; loop_ub++) {
    diff->data[loop_ub] = muDoubleScalarAbs(x->data[loop_ub]);
  }

  emxFree_real_T(&x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (pricerange.c) */
