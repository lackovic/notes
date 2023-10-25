# ffmpeg

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Fix errors](#fix-errors)
- [Fix non-standard stored B-frames](#fix-non-standard-stored-b-frames)
- [Detect frozen parts](#detect-frozen-parts)
- [Remove frozen parts](#remove-frozen-parts)
- [Remove frozen parts without the audio](#remove-frozen-parts-without-the-audio)
- [Concatenate video files](#concatenate-video-files)
- [Extract the audio from a video](#extract-the-audio-from-a-video)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Fix errors

```sh
ffmpeg -err_detect ignore_err -i INPUT.avi -c copy OUTPUT.avi
```

## Fix non-standard stored B-frames

```sh
ffmpeg -i INPUT.avi -codec copy -bsf:v mpeg4_unpack_bframes OUTPUT.avi
```

## Detect frozen parts

```sh
ffmpeg -i .\INPUT.avi -vf "freezedetect=n=-60dB:d=2" -map 0:v:0 -f null -
```

## Remove frozen parts

```sh
ffmpeg -i INPUT.mp4 -vf mpdecimate -vsync vfr OUTPUT.mp4
```

## Remove frozen parts without the audio

```sh
ffmpeg -i INPUT.mkv -vf mpdecimate -map 0:v OUTPUT.mp4
```

## Concatenate video files

Use this method when your videos have the same parameters (width, height, formats/codecs) to avoid a re-encode.

First prepare a text file `mylist.txt` containing the list of files you want to concatenate, in the following format:

```
file '/path/to/file1'
file '/path/to/file2'
file '/path/to/file3'
``` 

Then run the following command:

```sh
ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4
```

- [Source](https://stackoverflow.com/questions/7333232/how-to-concatenate-two-mp4-files-using-ffmpeg)

## Extract the audio from a video

```sh
ffmpeg -i sample.mp4 -q:a 0 -map a sample.mp3
```
