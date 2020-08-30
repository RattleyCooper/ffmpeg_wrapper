# ffmpeg_wrapper
 ffmpeg wrapper intercepts the `WM_CLOSE` event sent by windows when a `taskkilll` command is sent to the wrapper's process, then shuts down ffmpeg gracefully.

This is meant to be shipped alongside ffmpeg in cases where the only way to ask ffmpeg to shut down gracefully is to send a `taskkill` command. ffmpeg doesn't run with a window handle unless you specifically give ffmpeg a window handle using the `start` command.  This still doesn't fix the fact that ffmpeg is not designed to handle this edge case.  ffmpeg doesn't handle any `WM_CLOSE` event, so assigning a window handle isn't enough.

Here is an example of how to start ffmpeg with ffmpeg_wrap:


```
ffmpeg_wrap.exe ffmpeg.exe -rtbufsize 150M -f gdigrab -framerate 30 -offset_x 448 -offset_y 240 -video_size 1024x600 -draw_mouse 1 -show_region 1 -i desktop -r 30 -preset ultrafast -tune zerolatency -movflags +faststart screen-recording.mp4
```

