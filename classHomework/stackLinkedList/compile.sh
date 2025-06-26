aarch64-linux-gnu-as -g linkedList.s -o linkedList.o
aarch64-linux-gnu-ld linkedList.o -o linkedList

#To run
qemu-aarch64 ./linkedList

#To debug
# qemu-aarch64 -g 1234 ./linkedList