#!/usr/bin/env bash

gcc -c -fPIC sample.c -o sample.o
gcc sample.o -shared -o libsample.so

