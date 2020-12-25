set disassembly-flavor intel
source ~/.gdbinit-gef.py
source ~/.gdbscripts/gdb_at.py
source ~/.gdbscripts/gdb_qemu.py

set pagination off
gef config context.show_registers_raw 1

#shell echo set environment LD_PRELOAD=/home/$USER/glibc-2.23/64/lib/libc.so.6 > /tmp/foo2.gdb
#source /tmp/foo2.gdb

gef config context.layout "regs code source stack threads trace extra memory"
gef config context.nb_lines_code 4
