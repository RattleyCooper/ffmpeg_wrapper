import os
import wNim
import winim
import nimpy

# Put python.dll into following folder
# C:/Users/username/AppData/Local/Microsoft/WindowsApps

var running_process = false
var the_proc: PyObject
let subprocess = pyImport("subprocess")
let py = pyBuiltinsModule()
let pipe = subprocess.PIPE

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
    the_proc = subprocess.Popen(command_str, stdin=pipe)

frame.connect(WM_CLOSE) do (event: wEvent):
  let pycommand = py.str.encode(py.str("q"), "utf-8")
  discard the_proc.communicate(input=pycommand)
  sleep(1000)
  discard the_proc.terminate()
  quit(0)

frame.center()
app.mainLoop()
