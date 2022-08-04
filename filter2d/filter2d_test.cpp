
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "filter2d.h"

#include <iostream>
using namespace std;

int main()
{
    DTYPE input[16384];
    DTYPE output[15876];
    int gold;
    int in;

    int imgheight = 128;
    int imgwidth = 128;

    DTYPE kernel[9] = {-1,-2,-1,0,0,0,1,2,1};

    FILE * fp = fopen("src.txt","r");
    FILE * fpo = fopen("dst.txt","r");
    
    for(int i=0; i<16384; i++)
    {
        fscanf(fp, "%d", &in);
        input[i] = in;
    }

	filter2d_accel(input, kernel, output, imgheight, imgwidth);
    
    int tf = 0;

    for(int i=0; i<15876; i++)
    {
        fscanf(fpo, "%d", &gold);
        if (output[i] - gold != 0)
        {
            tf = 1;
        }        
    }

    fclose(fp);
    fclose(fpo);

    if (tf == 1)
    {
        fprintf(stdout, "*******************************************\n");
        fprintf(stdout, "FAIL: Output DOES NOT match the golden output\n");
        fprintf(stdout, "*******************************************\n");
        return 1;
    } 
    else 
    {
        fprintf(stdout, "*******************************************\n");
        fprintf(stdout, "PASS: The output matches the golden output!\n");
        fprintf(stdout, "*******************************************\n");
        return 0;
    }

}
