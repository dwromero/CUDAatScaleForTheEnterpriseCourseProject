# SO(2) x S Image Transformations using NVIDIA NPP with CUDA

## Overview

This project demonstrates the use of NVIDIA Performance Primitives (NPP) library with CUDA to perform SO(2) x S image transformations. The goal is to utilize GPU acceleration to efficiently apply rotation and scaling transformations to images, where SO(2) represents 2D rotations (Special Orthogonal group in 2D) and S represents scaling operations. This combination allows for comprehensive geometric transformations leveraging the computational power of modern GPUs. The project is a part of the CUDA at Scale for the Enterprise course and serves as an example of advanced image processing operations using CUDA and NPP.

## Code Organization

```bin/```
This folder should hold all binary/executable code that is built automatically or manually. Executable code should have use the .exe extension or programming language-specific extension.

```data/```
This folder should hold all example data in any format. If the original data is rather large or can be brought in via scripts, this can be left blank in the respository, so that it doesn't require major downloads when all that is desired is the code/structure.

```lib/```
Any libraries that are not installed via the Operating System-specific package manager should be placed here, so that it is easier for inclusion/linking.

```src/```
The source code should be placed here in a hierarchical fashion, as appropriate.

```README.md```
This file should hold the description of the project so that anyone cloning or deciding if they want to clone this repository can understand its purpose to help with their decision.

```INSTALL```
This file should hold the human-readable set of instructions for installing the code so that it can be executed. If possible it should be organized around different operating systems, so that it can be done by as many people as possible with different constraints.

```Makefile or CMAkeLists.txt or build.sh```
There should be some rudimentary scripts for building your project's code in an automatic fashion.

```run.sh```
An optional script used to run your executable code, either with or without command-line arguments.

## Key Concepts

Performance Strategies, Image Processing, NPP Library, Geometric Transformations, SO(2) Group Theory, Scaling Transformations

## Supported SM Architectures

[SM 3.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 3.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.1 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows

## Supported CPU Architecture

x86_64, ppc64le, armv7l

## CUDA APIs involved

## Dependencies needed to build/run
[FreeImage](../../README.md#freeimage), [NPP](../../README.md#npp)

## Prerequisites

Download and install the [CUDA Toolkit 11.4](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.
Make sure the dependencies mentioned in [Dependencies]() section above are installed.

## Build and Run

### Windows
The Windows samples are built using the Visual Studio IDE. Solution files (.sln) are provided for each supported version of Visual Studio, using the format:
```
*_vs<version>.sln - for Visual Studio <version>
```
Each individual sample has its own set of solution files in its directory:

To build/examine all the samples at once, the complete solution files should be used. To build/examine a single sample, the individual sample solution files should be used.
> **Note:** Some samples require that the Microsoft DirectX SDK (June 2010 or newer) be installed and that the VC++ directory paths are properly set up (**Tools > Options...**). Check DirectX Dependencies section for details."

### Linux
The Linux samples are built using makefiles. To use the makefiles, change the current directory to the sample directory you wish to build, and run make:
```
$ cd <sample_dir>
$ make
```
The samples makefiles can take advantage of certain options:
*  **TARGET_ARCH=<arch>** - cross-compile targeting a specific architecture. Allowed architectures are x86_64, ppc64le, armv7l.
    By default, TARGET_ARCH is set to HOST_ARCH. On a x86_64 machine, not setting TARGET_ARCH is the equivalent of setting TARGET_ARCH=x86_64.<br/>
`$ make TARGET_ARCH=x86_64` <br/> `$ make TARGET_ARCH=ppc64le` <br/> `$ make TARGET_ARCH=armv7l` <br/>
    See [here](http://docs.nvidia.com/cuda/cuda-samples/index.html#cross-samples) for more details.
*   **dbg=1** - build with debug symbols
    ```
    $ make dbg=1
    ```
*   **SMS="A B ..."** - override the SM architectures for which the sample will be built, where `"A B ..."` is a space-delimited list of SM architectures. For example, to generate SASS for SM 50 and SM 60, use `SMS="50 60"`.
    ```
    $ make SMS="50 60"
    ```

*  **HOST_COMPILER=<host_compiler>** - override the default g++ host compiler. See the [Linux Installation Guide](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#system-requirements) for a list of supported host compilers.
```
    $ make HOST_COMPILER=g++
```


## Running the Program

### Quick Start with Make Targets
After building the project, you can run the program using several convenient make targets:

```bash
# Default: 45° rotation, 1.0 scale
make run

# Demo: 45° rotation with 1.5x scaling  
make run-demo

# Rotation only: 90° rotation, no scaling
make run-rotate

# Scaling only: 2x scaling, no rotation
make run-scale
```

### Direct Binary Execution
If you wish to run the binary directly with custom input/output files and transformation parameters, you can use:

```bash
./bin/imageTransformNPP --input data/Lena.png --output data/Lena_transformed.png --rotation 45 --scale 1.5
```

### Transformation Parameters

- `--rotation <angle>`: Rotation angle in degrees (default: 45)
- `--scale <factor>`: Scaling factor (default: 1.0, values > 1.0 enlarge, < 1.0 shrink)
- `--input <path>`: Input image file path
- `--output <path>`: Output image file path

### Advanced Example Usage

```bash
# Apply 30-degree rotation with 2x scaling
./bin/imageTransformNPP --input data/Lena.png --output data/result.png --rotation 30 --scale 2.0

# Apply 90-degree rotation with 0.5x scaling (shrink)
./bin/imageTransformNPP --input data/Lena.png --output data/result.png --rotation 90 --scale 0.5

# Apply only rotation (no scaling)
./bin/imageTransformNPP --input data/Lena.png --output data/result.png --rotation 180 --scale 1.0
```

## Cleaning Up
To clean up the compiled binaries and other generated files, run:

```bash
make clean
```

This will remove all files in the bin/ directory.
