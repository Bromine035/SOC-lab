#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir
    outputsignal[0] = 0;
    outputsignal[1] = 0;
    outputsignal[2] = 0;
    outputsignal[3] = 0;
    outputsignal[4] = 0;
    outputsignal[5] = 0;
    outputsignal[6] = 0;
    outputsignal[7] = 0;
    outputsignal[8] = 0;
    outputsignal[9] = 0;
    outputsignal[10] = 0;
    ri0 = 0;
    ri1 = 0;
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	initfir();
	//write down your fir
    for(ri0 = 0; ri0 < N; ri0++)
    {
        for(ri1 = ri0; ri1 >= 0; ri1--)
        {
            outputsignal[ri0] += taps[ri0 - ri1] * inputsignal[ri1];
        }
    }
	return outputsignal;
}
		
