#include <stdio.h>
#include <stdlib.h>

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

struct Triple {
   unsigned char data1;
   unsigned char data2;
   unsigned char data3;
};

struct Triple* getStructPointer() {
    printf("creating struct\n");
    struct Triple *p1;
    p1 = malloc(sizeof(struct Triple));
    p1->data1 = 10;
    p1->data2 = 155;
    p1->data3 = 210;
    return p1;
}

struct Triple getStruct() {
    printf("creating struct\n");
    struct Triple data = { 10, 123, 55};
    return data;
}
