# ffmpeg wrapper

 ffmpeg wrapper intercepts the `WM_CLOSE` event sent by windows when a `taskkilll` command is sent to the wrapper's process, then shuts down ffmpeg gracefully.

This is meant to be shipped alongside ffmpeg in cases where the only way to ask ffmpeg to shut down gracefully is to send a `taskkill` command. ffmpeg doesn't run with a window handle unless you specifically give ffmpeg a window handle using the `start` command.  This still doesn't fix the fact that ffmpeg is not designed to handle this edge case.  ffmpeg doesn't handle any `WM_CLOSE` event, so assigning a window handle isn't enough.  ffmpeg_wrap can start ffmpeg and manage the process.  It will shut down ffmpeg cleanly when `taskkill` is used to kill ffmpeg_wrap.  Just don't use the `/F` opotion or it won't work.

## Compiling

`ffmpeg_wrap` is written with `nim`.  You need `wnim` and `winim` if you want to compile `ffmpeg_wrap`.  You can use `nimble` to get both.

`nimble install winim`
`nimble install wnim`

The resulting binary is around 1.5mb, but if you compile with the `--opt:size` flag it's less than 700kb

## Example Usage

This will record a section of your screen until you run `taskkill /PID FFMPEG_WRAP_PID`

```
ffmpeg_wrap.exe ffmpeg.exe -rtbufsize 150M -f gdigrab -framerate 30 -offset_x 448 -offset_y 240 -video_size 1024x600 -draw_mouse 1 -show_region 1 -i desktop -r 30 -preset ultrafast -tune zerolatency -movflags +faststart screen-recording.mp4
```

