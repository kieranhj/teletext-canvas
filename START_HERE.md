# teletext-canvas: start here

A MODE 7 "large canvas" viewer for the BBC Micro: a teletext picture taller than the screen (up to
200 rows) that you scroll around, shown with Steve's castle picture in black-and-white and colour.
A small 2017 6502 experiment (beebasm).

| | |
|---|---|
| GitHub | https://github.com/kieranhj/teletext-canvas (public) |
| Local path | D:\beeb\mine\teletext-canvas (moved from OneDrive\BEEB\Repos\teletext-canvas on 2026-11-22) |
| Branch | `master` (only branch) |
| Last commit | 2017-06-28: Colour version of Steve's castle |

## What's in here
- `canvas.asm` - the viewer; `canvas.ssd` - the built disc (committed).
- `castle_bw.txt`, `castle_colour.txt` and their `.bin` - the picture data.
- `teletext2bin.py` - converts a teletext text dump to `.bin` (ported to Python 3 on 2026-11-22; not called by the build). Usage: `python teletext2bin.py castle_bw.txt castle_bw.txt.bin`; it reproduces both committed `.bin` files byte for byte.
- `dragon_and_castle.docx` - a Word document (not opened here).
- `make.bat` (build), `run.bat` (B-em).

## Build and run
- `make`: runs `make.bat`: `..\..\Bin\beebasm.exe -i canvas.asm -do canvas.ssd -boot canvas -v`, listing
  in `compile.txt` (gitignored). The rebuilt `canvas.ssd` is byte-identical to the committed one.
- Tools: beebasm from D:\beeb\Bin (via `..\..\Bin`). No Python step in the build (2026-11-22: `make` run, `canvas.ssd` unchanged).
- Run: `run.bat` opens `canvas.ssd` in B-em (`..\..\bin\B-em\B-em.exe`); the disc boots on SHIFT+BREAK.

## Local changes
- None uncommitted. New, uncommitted: `Makefile`, `START_HERE.md`.

## Status and next steps
- Three commits, all on 2017-06-28; no TODO or plan notes found. Looks finished as an experiment.

## See also
- Related on D: `D:\beeb\mine\teletext-slojd` (MODE 7 canvas editor), `D:\bitshifters\teletextr`.
