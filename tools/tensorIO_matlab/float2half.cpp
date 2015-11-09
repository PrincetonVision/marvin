#include "mex.h"


unsigned short cpu_float2half(float f)
{
    unsigned short ret;

    unsigned x = *((int*)(void*)(&f));
    unsigned u = (x & 0x7fffffff), remainder, shift, lsb, lsb_s1, lsb_m1;
    unsigned sign, exponent, mantissa;

    // Get rid of +NaN/-NaN case first.
    if (u > 0x7f800000) {
        ret = 0x7fffU;
        return ret;
    }
  
    sign = ((x >> 16) & 0x8000);
  
    // Get rid of +Inf/-Inf, +0/-0.
    if (u > 0x477fefff) {
        ret = sign | 0x7c00U;
        return ret;
    }
    if (u < 0x33000001) {
        ret = (sign | 0x0000);
        return ret;
    }

    exponent = ((u >> 23) & 0xff);
    mantissa = (u & 0x7fffff);

    if (exponent > 0x70) {
        shift = 13;
        exponent -= 0x70;
    } else {
        shift = 0x7e - exponent;
        exponent = 0;
        mantissa |= 0x800000;
    }
    lsb = (1 << shift);
    lsb_s1 = (lsb >> 1);
    lsb_m1 = (lsb - 1);
  
    // Round to nearest even.
    remainder = (mantissa & lsb_m1);
    mantissa >>= shift;
    if (remainder > lsb_s1 || (remainder == lsb_s1 && (mantissa & 0x1))) {
        ++mantissa;
        if (!(mantissa & 0x3ff)) {
            ++exponent;
            mantissa = 0;
        }
    }  

    ret = (sign | (exponent << 10) | mantissa);  

    return ret;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

	mwSize ndim= mxGetNumberOfDimensions(prhs[0]);
	const mwSize * dims = mxGetDimensions(prhs[0]);
	size_t numel = mxGetNumberOfElements(prhs[0]);
	plhs[0] = mxCreateNumericArray(ndim, dims, mxUINT16_CLASS, mxREAL);
	
	float* p = (float*) mxGetData(prhs[0]);

	unsigned short* q = (unsigned short*) mxGetData(plhs[0]);
	unsigned short* qEnd = q+numel;

	while(q!=qEnd){
		*q = cpu_float2half(*p);
		++q;
		++p;
	}
}

