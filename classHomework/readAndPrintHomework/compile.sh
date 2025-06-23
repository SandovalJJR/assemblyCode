aarch64-linux-gnu-as -g readAndPrint.s -o readAndPrint.o
aarch64-linux-gnu-ld readAndPrint.o -o readAndPrint

# To Run
qemu-aarch64 ./readAndPrint

# To Debug
# qemu-aarch64 -g 1234 ./readAndPrint