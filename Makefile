################################################################################
# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
################################################################################
#
# Makefile project only supported on Mac OS X and Linux Platforms)
#
################################################################################

# Define the compiler and flags
NVCC = /usr/local/cuda/bin/nvcc
CXX = g++
CXXFLAGS = -std=c++11 -I/usr/local/cuda/include -Icuda-samples/Common -Icuda-samples/Common/UtilNPP -I.
LDFLAGS = -L/usr/local/cuda/lib64 -lcudart -lnppc -lnppial -lnppicc -lnppidei -lnppif -lnppig -lnppim -lnppist -lnppisu -lnppitc -lfreeimage

# Define directories
SRC_DIR = src
BIN_DIR = bin
DATA_DIR = data
OUTPUTS_DIR = outputs
LIB_DIR = lib

# Define source files and target executable
SRC = $(SRC_DIR)/imageTransformNPP.cpp
TARGET = $(BIN_DIR)/imageTransformNPP

# Define the default rule
all: $(TARGET)

# Rule for building the target executable
$(TARGET): $(SRC)
	mkdir -p $(BIN_DIR)
	mkdir -p $(OUTPUTS_DIR)
	$(NVCC) $(CXXFLAGS) $(SRC) -o $(TARGET) $(LDFLAGS)

# Rule for running the application with default parameters
run: $(TARGET)
	./$(TARGET) --input=$(DATA_DIR)/Lena_gray.png --output=$(OUTPUTS_DIR)/Lena_transformed.pgm

# Rule for running with custom rotation and scaling
run-demo: $(TARGET)
	./$(TARGET) --input=$(DATA_DIR)/Lena_gray.png --output=$(OUTPUTS_DIR)/Lena_demo.pgm --rotation=45 --scale=1.5

# Rule for running an SE(2) x S transformation demo
run-se2-demo: $(TARGET)
	./$(TARGET) --input=$(DATA_DIR)/Lena_gray.png --output=$(OUTPUTS_DIR)/Lena_se2_demo.pgm --rotation=30 --scale=1.2 --tx=50 --ty=-25

# Rule for running with rotation only
run-rotate: $(TARGET)
	./$(TARGET) --input=$(DATA_DIR)/Lena_gray.png --output=$(OUTPUTS_DIR)/Lena_rotated.pgm --rotation=90 --scale=1.0

# Rule for running with scaling only
run-scale: $(TARGET)
	./$(TARGET) --input=$(DATA_DIR)/Lena_gray.png --output=$(OUTPUTS_DIR)/Lena_scaled.pgm --rotation=0 --scale=2.0

# Run all demos
run-all-demos: $(TARGET)
	make run-se2-demo
	make run-rotate
	make run-scale
	make run-demo

# Convert PGM files to PNG format
convert-to-png:
	cd $(OUTPUTS_DIR) && python convert_pgm_to_png.py

# Clean up
clean:
	rm -rf $(BIN_DIR)/*
	rm -rf $(OUTPUTS_DIR)/*.pgm
	rm -rf $(OUTPUTS_DIR)/png_outputs/*.png

# Installation rule (not much to install, but here for completeness)
install:
	@echo "No installation required."

# Help command
help:
	@echo "Available make commands:"
	@echo "  make              - Build the project."
	@echo "  make run          - Run with default parameters (45° rotation, 1.0 scale)."
	@echo "  make run-demo     - Run demo with 45° rotation and 1.5x scaling."
	@echo "  make run-se2-demo - Run demo with 30° rotation, 1.2x scaling, and translation."
	@echo "  make run-rotate   - Run with 90° rotation only."
	@echo "  make run-scale    - Run with 2x scaling only."
	@echo "  make convert-to-png - Convert all PGM files in outputs/ to PNG format."
	@echo "  make clean        - Clean up the build files."
	@echo "  make install      - Install the project (if applicable)."
	@echo "  make help         - Display this help message."
	@echo ""
	@echo "SO(2) x S Transformation Parameters:"
	@echo "  --rotation <angle>   Rotation angle in degrees"
	@echo "  --scale <factor>     Scaling factor"
	@echo "  --tx <value>         X-axis translation"
	@echo "  --ty <value>         Y-axis translation"
	@echo "  --input <path>       Input image file path"
	@echo "  --output <path>      Output image file path (saved as .pgm format)"
	@echo ""
	@echo "Note: Output files are saved in PGM format. Use 'make convert-to-png' to convert to PNG."
