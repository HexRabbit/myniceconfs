set disassembly-flavor intel
#source ~/peda/peda.py

define at
	shell echo attach $(pidof -s $arg0) > /tmp/foo.gdb
	source /tmp/foo.gdb
end
