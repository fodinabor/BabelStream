/*=============================================================================
*------------------------------------------------------------------------------
* Copyright 2015: Tom Deakin, Simon McIntosh-Smith, University of Bristol HPC
* Based on John D. McCalpin’s original STREAM benchmark for CPUs
*------------------------------------------------------------------------------
* License:
*  1. You are free to use this program and/or to redistribute
*     this program.
*  2. You are free to modify this program for your own use,
*     including commercial use, subject to the publication
*     restrictions in item 3.
*  3. You are free to publish results obtained from running this
*     program, or from works that you derive from this program,
*     with the following limitations:
*     3a. In order to be referred to as "GPU-STREAM benchmark results",
*         published results must be in conformance to the GPU-STREAM
*         Run Rules published at
*         http://github.com/UoB-HPC/GPU-STREAM/wiki/Run-Rules
*         and incorporated herein by reference.
*         The copyright holders retain the
*         right to determine conformity with the Run Rules.
*     3b. Results based on modified source code or on runs not in
*         accordance with the GPU-STREAM Run Rules must be clearly
*         labelled whenever they are published.  Examples of
*         proper labelling include:
*         "tuned GPU-STREAM benchmark results" 
*         "based on a variant of the GPU-STREAM benchmark code"
*         Other comparable, clear and reasonable labelling is
*         acceptable.
*     3c. Submission of results to the GPU-STREAM benchmark web site
*         is encouraged, but not required.
*  4. Use of this program or creation of derived works based on this
*     program constitutes acceptance of these licensing restrictions.
*  5. Absolutely no warranty is expressed or implied.
*———————————————————————————————————-----------------------------------------*/


#ifdef FLOAT
	#define DATATYPE float
	constant DATATYPE scalar = 3.0f;
#else
	#pragma OPENCL EXTENSION cl_khr_fp64 : enable
	#define DATATYPE double
	constant DATATYPE scalar = 3.0;
#endif


kernel void copy(global const DATATYPE * restrict a, global DATATYPE * restrict c)
{
	const size_t i = get_global_id(0);
	c[i] = a[i];
}

kernel void mul(global DATATYPE * restrict b, global const DATATYPE * restrict c)
{
	const size_t i = get_global_id(0);
	b[i] = scalar * c[i];
}

kernel void add(global const DATATYPE * restrict a, global const DATATYPE * restrict b, global DATATYPE * restrict c)
{
	const size_t i = get_global_id(0);
	c[i] = a[i] + b[i];
}

kernel void triad(global DATATYPE * restrict a, global const DATATYPE * restrict b, global const DATATYPE * restrict c)
{
	const size_t i = get_global_id(0);
	a[i] = b[i] + scalar * c[i];
}
