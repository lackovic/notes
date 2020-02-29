# ffmpeg

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
