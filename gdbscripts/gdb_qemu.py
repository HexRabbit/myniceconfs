import gdb

class Qemu(gdb.Command):

    """Attach to qemu
    Usage: qemu [port]
    Example:
        (gdb) qemu 5455"""

    def __init__(self):
        super(self.__class__, self).__init__("qemu", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        if len(gdb.objfiles()) == 0:
            raise gdb.GdbError('Need vmlinux to set architecture')

        port = args or 1234
        gdb.execute(f'target remote :{port}')

Qemu()
