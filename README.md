# ffmpeg wrapper

 ffmpeg wrapper starts an ffmpeg process and hooks the `WM_CLOSE` event sent by windows when a `taskkilll` command is sent to the wrapper's process. The wrapper then shuts down the child ffmpeg process it started gracefully to avoid file corruption issues.

This is meant to be shipped alongside ffmpeg in cases where the only way to tell ffmpeg to shut down gracefully is to send a `taskkill` command(ffmpeg is being used by host software that needs to interrupt ffmpeg). ffmpeg doesn't run with a window handle unless you specifically give ffmpeg a window handle using the `start` command. This still doesn't fix the fact that ffmpeg is not designed to handle this edge case. ffmpeg doesn't handle any `WM_CLOSE` event, so assigning a window handle isn't enough.

Don't use the `/F` option or the `WM_CLOSE` event isn't fired and the wrapper will fail to shut down ffmpeg gracefully.

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

