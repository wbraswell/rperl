#ifndef __CPP__INCLUDED__rperlsse_h
#define __CPP__INCLUDED__rperlsse_h 0.001_100

typedef __m128d sse_number_pair;
#define sse_number_pair__new_from_singleton_duplicate(X) _mm_set1_pd(X)
#define sse_number_pair__new_from_pair(X, Y) _mm_setr_pd(X, Y)  // NEED TEST
#define constant_sse_number_pair__new_from_singleton_duplicate(X) _mm_set1_pd(X)
#define constant_sse_number_pair__new_from_pair(X, Y) _mm_setr_pd(X, Y)  // NEED TEST
#define sse_add +
#define sse_sub -
#define sse_mul *
#define sse_div /
#define sse_recip_sqrt_32bit_on_64bit(X) sse_number_32bit_to_64bit(sse_recip_sqrt_32bit(sse_number_64bit_to_32bit(X)))
#define sse_number_64bit_to_32bit _mm_cvtpd_ps
#define sse_number_32bit_to_64bit _mm_cvtps_pd
#define sse_recip_sqrt_32bit _mm_rsqrt_ps

#endif
