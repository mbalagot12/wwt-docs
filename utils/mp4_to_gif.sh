#!/bin/bash

# Check if ffmpeg and gifsicle are installed
if ! command -v ffmpeg &> /dev/null || ! command -v gifsicle &> /dev/null; then
    echo "ffmpeg and gifsicle are required but not installed. Please install them."
    exit 1
fi

# Create a directory for output GIFs if it doesn't exist
mkdir -p gifs_output

# Iterate over all MP4 files in the current directory
for video in *.mp4; do
    # Extract the filename without extension
    filename=$(basename "$video" .mp4)

    echo "Processing $video..."

    # Step 1: Convert MP4 to GIF using ffmpeg
    ffmpeg -i "$video" -filter_complex "[0:v] fps=12,scale=2000:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" "gifs_output/${filename}.gif"

    # Step 2: Optimize the GIF using gifsicle
    gifsicle -O2 "gifs_output/${filename}.gif" -o "gifs_output/${filename}_optimized.gif"

    # Optional: Delete the original unoptimized GIF
    rm "gifs_output/${filename}.gif"

    echo "$filename.mp4 converted to $filename_optimized.gif"
done

echo "All videos processed. Check the 'gifs_output' folder for the results."
