from subprocess import check_output
import gdb
import os

def pidof(name):
    try:
        res = check_output(["pidof", "-s", name])
    except subprocess.CalledProcessError:
        raise gdb.GdbError('No program named {} are now running.'.format(name))

    return int(res)

class At(gdb.Command):

    """Attach to current file name
    Usage: at
    Example:
        (gdb) file test
        (gdb) at"""

    def __init__(self):
        super(self.__class__, self).__init__("at", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        if len(gdb.objfiles()) == 0:
            raise gdb.GdbError('Get filename error, to view info, type "help at".')

        fullpath = gdb.objfiles()[0].filename
        filename = os.path.basename(fullpath)
        gdb.execute('attach {}'.format(pidof(filename)))

At()
