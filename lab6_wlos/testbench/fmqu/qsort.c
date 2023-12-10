#include "qsort.h"

int __attribute__ ( ( section ( ".mprjram" ) ) ) partition(int low,int hi){
	int pivot = Aq[hi];
	int i = low-1,j;
	int temp;
	for(j = low;j<hi;j++){
		if(Aq[j] < pivot){
			i = i+1;
			temp = Aq[i];
			Aq[i] = Aq[j];
			Aq[j] = temp;
		}
	}
	if(Aq[hi] < Aq[i+1]){
		temp = Aq[i+1];
		Aq[i+1] = Aq[hi];
		Aq[hi] = temp;
	}
	return i+1;
}

void __attribute__ ( ( section ( ".mprjram" ) ) ) sort(int low, int hi){
	if(low < hi){
		int p = partition(low, hi);
		sort(low,p-1);
		sort(p+1,hi);
	}
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) qsort(){
	sort(0,SIZE-1);
	return Aq;
}
