#!/usr/bin/env python
"""
PGM to PNG Converter
Converts all .pgm files in the outputs directory to .png format
and saves them in the png_outputs subdirectory.
"""

import os
import glob
import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Error: PIL (Pillow) library is required for image conversion.")
    print("Install it using: pip install Pillow")
    sys.exit(1)

def convert_pgm_to_png():
    """
    Convert all .pgm files in the current directory to .png format
    and save them in the png_outputs subdirectory.
    """
    # Get the current directory (outputs)
    current_dir = Path(__file__).parent
    png_output_dir = current_dir / "png_outputs"
    
    # Ensure png_outputs directory exists
    png_output_dir.mkdir(exist_ok=True)
    
    # Find all .pgm files in the current directory
    pgm_files = glob.glob(str(current_dir / "*.pgm"))
    
    if not pgm_files:
        print("No .pgm files found in the outputs directory.")
        return
    
    print(f"Found {len(pgm_files)} .pgm file(s) to convert:")
    converted_count = 0
    
    for pgm_file in pgm_files:
        try:
            pgm_path = Path(pgm_file)
            png_filename = pgm_path.stem + ".png"
            png_path = png_output_dir / png_filename
            
            # Open the PGM image
            with Image.open(pgm_path) as img:
                # Convert to PNG format and save
                img.save(png_path, "PNG")
                
            print(f"  ✓ Converted: {pgm_path.name} → png_outputs/{png_filename}")
            converted_count += 1
            
        except Exception as e:
            print(f"  ✗ Error converting {pgm_path.name}: {e}")
    
    print(f"\nConversion complete! Successfully converted {converted_count} out of {len(pgm_files)} files.")
    print(f"PNG files saved in: {png_output_dir}")

if __name__ == "__main__":
    print("=== PGM to PNG Converter ===")
    print("Converting .pgm files to .png format...")
    print()
    convert_pgm_to_png() 
