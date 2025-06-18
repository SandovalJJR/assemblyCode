# assemblyCode
Here there are a bunch of assembly code made in the course Computer and assembler's architectures 1 of Engineering Faculty of The San Carlos University of Guatemala.

# RUN ASSEMBLY AARCH64 ON WINDOWS
### STEPS:

1. Active the virtualization service on windows (if you have it activated skip this step)


```
Comand #1:
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Command #2:
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

And enable the virtualization in the BIOS settings.

2. Install wsl

```
wsl --install
```

3. Open a wsl bash, write the next command on a command line.

```
wsl
```

4. Install aarch64 toolchain and QEMU User Mode

```
sudo apt update && sudo apt upgrade -y
sudo apt install binutils-aarch64-linux-gnu qemu-user -y
```

5. Write your .s files and assemble and link the file with the next commands

To assemble
```
aarch64-linux-gnu-as test.s -o test.o
aarch64-linux-gnu-ld test.o -o test
```

To Link
```
aarch64-linux-gnu-ld test.o -o test
```