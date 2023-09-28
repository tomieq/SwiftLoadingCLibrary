#include <stdio.h>

// this function returns integer
int getNumber() {
    printf("This function returns 5\n");
    return 5;
}

// this function just executes, no parameter or return value
void noReturn() {
    printf("No returning function\n");
}

// this function takes array of 8-bits as parameter
void acceptBytes(char bytes[]) {
    printf("received bytes: ");
    while(*bytes) {
        printf("%x ", *bytes & 0xff);
        ++bytes;
    }
    printf("\n");
}

// this function updates data in variable that was in parameter
void initParameter(unsigned char variable[]) {
    variable[0] = 165;
    variable[1] = 91;
    variable[2] = 10;
    printf("variable initialized with 3 bytes\n");
}

