#include <stdio.h>
#include <stdlib.h>

// this function returns integer
int getNumber() {
    printf("[libC] This function returns 5\n");
    return 5;
}

// this function just executes, no parameter or return value
void noReturn() {
    printf("[libC] No returning function\n");
}

// this function takes array of 8-bits as parameter
void acceptBytes(const char bytes[]) {
    printf("[libC] received bytes: ");
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
    printf("[libC] variable initialized with 3 bytes\n");
}

struct Triple {
   unsigned char data1;
   unsigned char data2;
   unsigned char data3;
};

struct Triple* getStructPointer() {
    printf("[libC] creating struct 10, 155, 210\n");
    struct Triple *p1;
    p1 = malloc(sizeof(struct Triple));
    p1->data1 = 10;
    p1->data2 = 155;
    p1->data3 = 210;
    return p1;
}

struct Triple getStruct() {
    printf("[libC] creating struct 10, 123, 55\n");
    struct Triple data = { 10, 123, 55};
    return data;
}


typedef uint32_t tomint_t[4];
struct s_tompair {
    tomint_t x;
    tomint_t y;
};
typedef struct s_tompair tompair_t;

uint32_t calculate(uint32_t *table, tomint_t a, tompair_t *b, const uint8_t c[4]) {
    
    printf("Table values: ");
    for (int i = 0; i < 12; i++) {
        printf("%u ", table[i]);
    }
    printf("\n");

    printf("tomint_t a values: ");
    for (int i = 0; i < 4; i++) {
        printf("%u ", a[i]);
    }
    printf("\n");
                       
    printf("tompair_t b.x values: ");
    for (int i = 0; i < 4; i++) {
        printf("%u ", b->x[i]);
    }
    printf("\n");
                       
    printf("tompair_t b.y values: ");
    for (int i = 0; i < 4; i++) {
        printf("%u ", b->y[i]);
    }
    printf("\n");

    printf("Const uint8_t c values: ");
    for (int i = 0; i < 4; i++) {
        printf("%u ", c[i]);
    }
    printf("\n");
    return 10;
}
