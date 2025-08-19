## Utils Guides

## MP4 to Gifs

- To utilize the MP4 to Gif utility, you will need to copy the shell script into the directory in which you have the .mp4 files.

- Prior to initial use, you will need to change the shell script to be executable using `chmod +x mp4_to_gif.sh`

- Once the script is in the directory and can be executed run `./mp4_to_gif.sh`

- A new folder will be created in the current directory called `gifs_output`.  This is where the new gifs will be stored.

- Once the gifs have been created move them from the gifs_output directory into assets folder.

- Finally update any links you had in your Markdown lab guide to point to the `filename_optimized.gif` file instead of the `filename.mp4` file and remove the `mp4_to_gif.sh` file from the asset directory.
