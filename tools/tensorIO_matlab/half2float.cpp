#include "mex.h"

float cpu_half2float(unsigned short x)
{
    unsigned sign = ((x >> 15) & 1);
    unsigned exponent = ((x >> 10) & 0x1f);
    unsigned mantissa = ((x & 0x3ff) << 13);
    if (exponent == 0x1f) {  /* NaN or Inf */
        mantissa = (mantissa ? (sign = 0, 0x7fffff) : 0);
        exponent = 0xff;
    } else if (!exponent) {  /* Denorm or Zero */
        if (mantissa) {
            unsigned int msb;
            exponent = 0x71;
            do {
                msb = (mantissa & 0x400000);
                mantissa <<= 1;  /* normalize */
                --exponent;
            } while (!msb);
            mantissa &= 0x7fffff;  /* 1.mantissa is implicit */
        }
    } else {
        exponent += 0x70;
    }
    int temp = ((sign << 31) | (exponent << 23) | mantissa);

    return *((float*)((void*)&temp));
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

	mwSize ndim= mxGetNumberOfDimensions(prhs[0]);
	const mwSize * dims = mxGetDimensions(prhs[0]);
	size_t numel = mxGetNumberOfElements(prhs[0]);
	plhs[0] = mxCreateNumericArray(ndim, dims, mxSINGLE_CLASS, mxREAL);
	
	unsigned short* p = (unsigned short*) mxGetData(prhs[0]);
	float* q = (float*) mxGetData(plhs[0]);
	float* qEnd = q+numel;

	while(q!=qEnd){
		*q = cpu_half2float(*p);
		++q;
		++p;
	}
}

