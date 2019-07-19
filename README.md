# KiCad image on Ubuntu 18.04

Useful to script gerber generation, or other kicad stuff!

## Specifications

- kicad compiled without spice, demos, oce (3d display) and wxpython scripting (useless with python api)
- image weighs only 500MB
- image tag = kicad version

## Life Pro Tip: How to script functions which are not part of the python api

### Install requirements

```
apt install -y xvfb xdotool x11-utils x11-apps python3 python3-pip imagemagick
pip3 install pyvirtualdisplay
```

### Write script

* Create a python3 script
* Open a virtual display with: `pyvirtualdisplay.Display(visible=False, size=(1920,1080), color_depth=24).start()`
* Start `eeschema` (for example) in your virtual display using: `EasyProcess(['eeschema', <path to .sch>]).start()`
* Use `xdotool` to manipulate the virtual window and plot schematics, generate BOMs, etc
* To debug, take screenshots with `xwd -silent -root | convert xwd:- screenshot.png`

