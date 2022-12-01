import os
import osproc
import wNim
import winim


var running_process = false
var the_proc: Process
const procOpts = {
  poUsePath,
  poEvalCommand,
  poEchoCmd,
  poInteractive,
  poStdErrToStdOut,
  poParentStreams
}

let app = App()
let frame = Frame(title="ffmpeg_wrap", size=(400, 300))

frame.connect(WM_MOVE) do (event: wEvent):
  if running_process == false:
    running_process = true
    var command_str: string = paramStr(1)
    for i in 2..paramCount():
      var param: string = paramStr(i)
      if param.contains(' '):
        param = "\"" & paramStr(i) & "\""
      else:
        param = paramStr(i)
      command_str = command_str & " " & param
    the_proc = startProcess(command_str, "", [], nil, procOpts)

frame.connect(WM_CLOSE) do (event: wEvent):
  # Use windows API to send the Ctrl+C
  let ev: DWORD = 0
  let pid: DWORD = the_proc.processID()
  GenerateConsoleCtrlEvent(ev, pid)
  echo "Waiting for ffmpeg to finish..."
  discard the_proc.waitForExit(120000)
  echo "Ffmpeg finished!"
  if the_proc.running():
    echo "Terminating ffmpeg"
    the_proc.terminate()
  quit(QuitSuccess)

frame.center()
app.mainLoop()
