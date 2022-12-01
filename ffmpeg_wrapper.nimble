# Package

version       = "0.1.0"
author        = "py-am-i"
description   = "ffmpeg wrapper intercepts the WM_CLOSE event sent by windows when a taskkilll command is sent to the wrapper's process, then shuts down ffmpeg gracefully."
license       = "MIT"


# Dependencies

requires "nim >= 1.6.10"
requires "wNim"
requires "winim"
requires "nimpy"
