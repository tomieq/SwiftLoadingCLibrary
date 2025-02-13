# SwiftLoadingCLibrary

Sample project demonstrating loading dynamic C library into Swift app

## Compile C code to dynamic library

```
gcc -c -fPIC sample.c -o sample.o
gcc sample.o -shared -o libsample.so
```

Or simply use bash:
```
./compile.sh
```
Check whether all functions are present:
```
nm libsample.so
```

## Compile Swift code

```
swift build
```
Run:
```
.build/debug/SwiftLoadingCLibrary
```
