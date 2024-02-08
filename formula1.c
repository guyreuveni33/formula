
#include <immintrin.h>
#include <stdio.h>
#include <math.h>

float formula1(float *x, unsigned int length) {
    unsigned int divided_length = length / 4;
    unsigned int remainder_length = length % 4;
    __m128 sqrt_sum = _mm_setzero_ps();
    __m128 vec1;

    for (unsigned int i = 0; i < divided_length; i++) {
        vec1 = _mm_load_ps(x);
        __m128 sqrt_arr = _mm_sqrt_ps(vec1);
        sqrt_sum = _mm_add_ps(sqrt_sum, sqrt_arr);
        x += 4;
    }

    __m128 sum = _mm_hadd_ps(sqrt_sum, sqrt_sum);
    sum = _mm_hadd_ps(sum, sum);
    float final_sqrt_sum = sum[0];

    if (remainder_length == 1) {
        final_sqrt_sum += sqrtf(x[0]);
    } else if (remainder_length == 2) {
        final_sqrt_sum += sqrtf(x[0]);
        final_sqrt_sum += sqrtf(x[1]);
    } else if (remainder_length == 3) {
        final_sqrt_sum += sqrtf(x[0]);
        final_sqrt_sum += sqrtf(x[1]);
        final_sqrt_sum += sqrtf(x[2]);
    }

    float third_sqrt_sum = powf(final_sqrt_sum, 1.0 / 3.0);

    // Reset the pointer to its original position
    x -= divided_length * 4;

    __m128 vec2;
    __m128 vec2_shuffle;
    __m128 vec3 = _mm_setzero_ps();
    vec3 = _mm_add_ps(vec3, _mm_set1_ps(1));
    // float shuffle_sum = 1; // Unused variable

    for (unsigned int i = 0; i < divided_length; i++) {
        vec2 = _mm_load_ps(x);
        vec2 = _mm_mul_ps(vec2, vec2);
        vec2 = _mm_add_ps(vec2, _mm_set1_ps(1));

        // Horizontal multiplication
        vec2_shuffle = _mm_mul_ps(vec2, _mm_permute_ps(vec2, _MM_SHUFFLE(2, 3, 0, 1)));
        vec2_shuffle = _mm_mul_ps(vec2_shuffle, _mm_permute_ps(vec2_shuffle, _MM_SHUFFLE(1, 0, 3, 2)));
        // shuffle_sum *= vec2_shuffle[0]; // Unused variable
        vec3 = _mm_mul_ps(vec3, vec2_shuffle);

        x += 4;
    }

    float vec2_remainder_mul = 1;
    if (remainder_length == 1) {
        vec2_remainder_mul *= (x[0] * x[0] + 1);
    } else if (remainder_length == 2) {
        vec2_remainder_mul *= (x[0] * x[0] + 1);
        vec2_remainder_mul *= (x[1] * x[1] + 1);
    } else if (remainder_length == 3) {
        vec2_remainder_mul *= (x[0] * x[0] + 1);
        vec2_remainder_mul *= (x[1] * x[1] + 1);
        vec2_remainder_mul *= (x[2] * x[2] + 1);
    }

    float final_mul = vec2_remainder_mul * vec3[0];

    return sqrtf(1 + (third_sqrt_sum / final_mul));
}
