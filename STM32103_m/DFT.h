
#ifndef __DFT_H__
#define __DFT_H__

#define  NUMBER_IS_2_POW_K(x)   ((!((x)&((x)-1)))&&((x)>1))  // x is pow(2, k), k=1,2, ...
#define  FT_DIRECT        -1    // Direct transform.
#define  FT_INVERSE        1    // Inverse transform.

bool  FFT(float *Rdat, float *Idat, int N, int LogN, int Ft_Flag);

#endif