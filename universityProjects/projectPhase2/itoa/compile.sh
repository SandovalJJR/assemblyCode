#aarch64-linux-gnu-as -g itoa.s -o itoa.o
#aarch64-linux-gnu-as -g printNum.s -o printNum.o
#aarch64-linux-gnu-as -g main.s -o main.o

#aarch64-linux-gnu-ld main.o itoa.o printNum.o -o main
#qemu-aarch64 ./main

aarch64-linux-gnu-as -g writeXML.s -o writeXML.o
aarch64-linux-gnu-ld writeXML.o itoa.o -o writeXML
qemu-aarch64 ./writeXML