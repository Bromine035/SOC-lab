#ifndef __FINAL_H__
#define __FINAL_H__

// #define N 11
// int __attribute__ ( ( section ( ".fir_tap" ) ) ) taps[N] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
// int __attribute__ ( ( section ( ".fir_x" ) ) ) inputsignal[N] = {1,2,3,4,5,6,7,8,9,10,11};
// int __attribute__ ( ( section ( ".fir_y" ) ) ) outputsignal[N];

// #define SIZE 4
// int __attribute__ ( ( section ( ".mm_a" ) ) ) Am[SIZE*SIZE] = {0, 1, 2, 3,
//         0, 1, 2, 3,
//         0, 1, 2, 3,
//         0, 1, 2, 3,
// };
// int __attribute__ ( ( section ( ".mm_b" ) ) ) Bm[SIZE*SIZE] = {1, 2, 3, 4,
//     5, 6, 7, 8,
//     9, 10, 11, 12,
//     13, 14, 15, 16,
// };
// int __attribute__ ( ( section ( ".mm_o" ) ) ) Mo[SIZE*SIZE];

// #define LENG 10
// int __attribute__ ( ( section ( ".qs_a" ) ) ) Aq[LENG] = {893, 40, 3233, 4267, 2669, 2541, 9073, 6023, 5681, 4622};
// int __attribute__ ( ( section ( ".qs_o" ) ) ) Vo[LENG];


#define Nt 11
#define Nx 16
int __attribute__ ( ( section ( ".fir_tap" ) ) ) taps[Nt];
int __attribute__ ( ( section ( ".fir_x" ) ) ) inputsignal[Nx];
int __attribute__ ( ( section ( ".fir_y" ) ) ) outputsignal[Nx];

#define SIZE 16 // should be square number
int __attribute__ ( ( section ( ".mm_a" ) ) ) Am[SIZE];
int __attribute__ ( ( section ( ".mm_b" ) ) ) Bm[SIZE];
int __attribute__ ( ( section ( ".mm_o" ) ) ) Mo[SIZE];

#define LENG 16
int __attribute__ ( ( section ( ".qs_a" ) ) ) Aq[LENG];
int __attribute__ ( ( section ( ".qs_o" ) ) ) Vo[LENG];

void init_data(){
    taps[0] = 0;
    taps[1] = -10;
    taps[2] = -9;
    taps[3] = 23;
    taps[4] = 56;
    taps[5] = 63;
    taps[6] = 56;
    taps[7] = 23;
    taps[8] = -9;
    taps[9] = -10;
    taps[10] = 0;

    inputsignal[0] = 1;
    inputsignal[1] = 2;
    inputsignal[2] = 3;
    inputsignal[3] = 4;
    inputsignal[4] = 5;
    inputsignal[5] = 6;
    inputsignal[6] = 7;
    inputsignal[7] = 8;
    inputsignal[8] = 9;
    inputsignal[9] = 10;
    inputsignal[10] = 11;
    inputsignal[11] = 12;
    inputsignal[12] = 13;
    inputsignal[13] = 14;
    inputsignal[14] = 15;
    inputsignal[15] = 16;

    // outputsignal[0] = 0;
    // outputsignal[1] = 0;
    // outputsignal[2] = 0;
    // outputsignal[3] = 0;
    // outputsignal[4] = 0;
    // outputsignal[5] = 0;
    // outputsignal[6] = 0;
    // outputsignal[7] = 0;
    // outputsignal[8] = 0;
    // outputsignal[9] = 0;
    // outputsignal[10] = 0;

    Am[0] = 0;
    Am[1] = 1;
    Am[2] = 2;
    Am[3] = 3;
    Am[4] = 0;
    Am[5] = 1;
    Am[6] = 2;
    Am[7] = 3;
    Am[8] = 0;
    Am[9] = 1;
    Am[10] = 2;
    Am[11] = 3;
    Am[12] = 0;
    Am[13] = 1;
    Am[14] = 2;
    Am[15] = 3;

    Bm[0] = 1;
    Bm[1] = 2;
    Bm[2] = 3;
    Bm[3] = 4;
    Bm[4] = 5;
    Bm[5] = 6;
    Bm[6] = 7;
    Bm[7] = 8;
    Bm[8] = 9;
    Bm[9] = 10;
    Bm[10] = 11;
    Bm[11] = 12;
    Bm[12] = 13;
    Bm[13] = 14;
    Bm[14] = 15;
    Bm[15] = 16;

    Aq[0] = 893;
    Aq[1] = 40;
    Aq[2] = 3233;
    Aq[3] = 4267;
    Aq[4] = 1;
    Aq[5] = 2541;
    Aq[6] = 9073;
    Aq[7] = 6023;
    Aq[8] = 5681;
    Aq[9] = 4622;
    Aq[10] = 4622;
    Aq[11] = -1234;
    Aq[12] = -5678;
    Aq[13] = -1234;
    Aq[14] = 0;
    Aq[15] = -1;
    // Aq[9] = 4622;
}

#endif
