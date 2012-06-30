" TODO: add debugger capabilites
" TODO: readd autocomplete
" TODO: fine-tune help window
" TODO: use a kernel, instead of qtconsole
" TODO: figure out what is wrong with ion()
" TODO: add current variable buffer
" TODO: add shutdown kernel procedure (so it doesn't need to be closed
" manually)
" TODO: better error display
" TODO: add ? and ?? functionality
" TODO: make status line update

if !has('python')
    " exit if python is not available.
    finish
endif

" Allow custom mappings.
if !exists('g:ipy_perform_mappings')
    let g:ipy_perform_mappings = 1
endif

python << EOF
reselect = False            # reselect lines after sending from Visual mode
show_execution_count = True # wait to get numbers for In[43]: feedback?
monitor_subchannel = True   # update vim-ipython 'shell' on every send?
run_flags= "-i"             # flags to for IPython's run magic when using <F5>
current_line = ''
open_docbuffer = False   # used to toggle the doc buffer open or closed with K

import vim
import sys
import re
from os.path import basename

# get around unicode problems when interfacing with vim
vim_encoding = vim.eval('&encoding') or 'utf-8'

try:
    sys.stdout.flush
except AttributeError:
    # IPython complains if stderr and stdout don't have flush
    # this is fixed in newer version of Vim
    class WithFlush(object):
        def __init__(self,noflush):
            self.write=noflush.write
            self.writelines=noflush.writelines
        def flush(self):pass
    sys.stdout = WithFlush(sys.stdout)
    sys.stderr = WithFlush(sys.stderr)

ip = '127.0.0.1'
try:
    km
except NameError:
    km = None
try:
    pid
except NameError:
    pid = None

debugging = False
def km_from_string(s=''):
    """create kernel manager from IPKernelApp string
    such as '--shell=47378 --iopub=39859 --stdin=36778 --hb=52668' for IPython 0.11
    or just 'kernel-12345.json' for IPython 0.12
    """
    from os.path import join as pjoin
    from IPython.zmq.blockingkernelmanager import BlockingKernelManager, Empty
    from IPython.config.loader import KeyValueConfigLoader
    from IPython.zmq.kernelapp import kernel_aliases
    global km, Empty

    s = s.replace('--existing', '')
    if 'connection_file' in BlockingKernelManager.class_trait_names():
        from IPython.lib.kernel import find_connection_file
        # 0.12 uses files instead of a collection of ports
        # include default IPython search path
        # filefind also allows for absolute paths, in which case the search
        # is ignored
        try:
            # XXX: the following approach will be brittle, depending on what
            # connection strings will end up looking like in the future, and
            # whether or not they are allowed to have spaces. I'll have to sync
            # up with the IPython team to address these issues -pi
            if '--profile' in s:
                k,p = s.split('--profile')
                k = k.lstrip().rstrip() # kernel part of the string
                p = p.lstrip().rstrip() # profile part of the string
                fullpath = find_connection_file(k,p)
            else:
                fullpath = find_connection_file(s.lstrip().rstrip())
        except IOError,e:
            echo(":IPython " + s + " failed", "Info")
            echo("^-- failed '" + s + "' not found", "Error")
            return
        km = BlockingKernelManager(connection_file = fullpath)
        km.load_connection_file()
    else:
        if s == '':
            echo(":IPython 0.11 requires the full connection string")
            return
        loader = KeyValueConfigLoader(s.split(), aliases=kernel_aliases)
        cfg = loader.load_config()['KernelApp']
        try:
            km = BlockingKernelManager(
                shell_address=(ip, cfg['shell_port']),
                sub_address=(ip, cfg['iopub_port']),
                stdin_address=(ip, cfg['stdin_port']),
                hb_address=(ip, cfg['hb_port']))
        except KeyError,e:
            echo(":IPython " +s + " failed", "Info")
            echo("^-- failed --"+e.message.replace('_port','')+" not specified", "Error")
            return
    km.start_channels()

    set_pid()
    return km

def setup_vib():
    """ Setup vib (vim-ipython buffer), that acts like a prompt.

    Must stay open while! """
    global vib
    
    if not get_vim_ipython_buffer():
        vim.command("rightbelow vnew vim-ipython.py")
        vim.current.buffer[0] = '>> '
        vim.command("startinsert!")
        vim.command("setl nonumber showbreak=\ \ \ ")
        vim.command("setl bufhidden=hide buftype=nofile ft=python noswf ")
        vim.command("hi Green ctermfg=Green guifg=#00ED45")
        vim.command("hi Red ctermfg=Red guifg=Red")
        vim.command("syn match Normal /^>>/")
        vim.command("syn match Red /^<</")
        vim.command("syn region Red start=/^ERROR >>$/ end=/^<< ERROR$/")
        vim.command("inoremap <buffer> <s-cr> <ESC>:py shift_enter_at_prompt()<CR>")
        vim.command("inoremap <buffer> <cr> <ESC>:py enter_at_prompt()<CR>")
        vim.command("map <buffer> <F12> <ESC><C-w>p")
        vim.command("imap <buffer> <F12> <ESC><C-w>p")
        # ctrl-C gets sent to the IPython process as a signal on POSIX
        vim.command("noremap <buffer>  :IPythonInterrupt<cr>")
        # add and auto command, so that the cursor always moves to the end
        # upon entereing the vim-ipython buffer
        vim.command("au WinEnter <buffer> :python insert_at_new()")

        # set the global variable for everyone to reference easily
        vib = get_vim_ipython_buffer()
    else:
        vib = get_vim_ipython_buffer()
        echo("vim-ipython.py is already open!")


def enter_at_prompt():
    vib.append('   ')
    vim.command('normal G')
    vim.command('startinsert!')

isinput = re.compile(r'^(\>\> |   )(.*)$')
def shift_enter_at_prompt():
    """ Remove prompts and whitespace before sending to ipython. """
    cmds = []
    lines = 1
    while lines <= len(vib) and isinput.match(vib[-lines]):
        cmds.append(vib[-lines][3:]) # remove the last three characters
        lines += 1
    cmds.reverse()
    if debugging:
        vib.append('Commands being sent from command prompt:')
        vib.append(cmds)
    cmds = '\n'.join(cmds)
    if cmds == 'cls':
        vib[:] = None # clear the buffer
        vib[-1] = '>> '
        vim.command('startinsert!')
    else:
        send(cmds)

blankprompt = re.compile(r'^\>\> $')
def send(cmds, *args, **kargs):
    """ Send commands to ipython kernel. 

    Format the input, then print the statements to the vim-ipython buffer.
    """
    formatted = None
    if not in_vim_ipython():
        # format and input text
        formatted = re.sub(r'\n',r'\n   ',cmds).splitlines()
        formatted[0] = '>> ' + formatted[0]

        # remove any prompts or blank lines
        while len(vib) > 1 and blankprompt.match(vib[-1]):
            del vib[-1]
            
        if blankprompt.match(vib[-1]):
            vib[-1] = formatted[0]
        else:
            vib.append(formatted) 
    if debugging and formatted:
        vib.append('formatted commands:')
        vib.append(cmds)

    return km.shell_channel.execute(cmds, *args, **kargs)

def is_vim_ipython_open():
    """
    Helper function to let us know if the vim-ipython shell is currently
    visible
    """
    for w in vim.windows:
        if w.buffer.name is not None and w.buffer.name.endswith("vim-ipython.py"):
            return True
    return False

def in_vim_ipython():
    cbn = vim.current.buffer.name
    if cbn:
        return cbn.endswith('vim-ipython.py')
    else:
        return False

def insert_at_new():
    """ Insert at the bottom of the file, if it is the ipy buffer. """
    if in_vim_ipython():
        # insert at end of last line
        vim.command('normal G')
        vim.command('startinsert!') 

def get_vim_ipython_buffer():
    """ Return the vim-ipython buffer. """
    for b in vim.buffers:
        if b.name.endswith("vim-ipython.py"):
            return b
    return False

def get_vim_ipython_window():
    """ Return the vim-ipython window. """
    for w in vim.windows:
        if w.buffer.name is not None and w.buffer.name.endswith("vim-ipython.py"):
            return w
    raise Exception("couldn't find ipython-vim window")

def echo(arg,style="Question"):
    try:
        vim.command("echohl %s" % style)
        vim.command("echom \"%s\"" % arg.replace('\"','\\\"'))
        vim.command("echohl None")
    except vim.error:
        print "-- %s" % arg

# from http://serverfault.com/questions/71285/in-centos-4-4-how-can-i-strip-escape-sequences-from-a-text-file
strip = re.compile('\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]')
def strip_color_escapes(s):
    return strip.sub('',s)

def update_subchannel_msgs(debug=False, force=False):
    """
    Grab any pending messages and place them inside the vim-ipython shell.
    This function will do nothing if the vim-ipython shell is not visible,
    unless force=True argument is passed.
    """
    if km is None or (not is_vim_ipython_open() and not force):
        return False
    newprompt = False

    msgs = km.sub_channel.get_msgs()
    for m in msgs:
        if debugging:
            vib.append('message from ipython:')
            vib.append(repr(m).splitlines())
        if 'msg_type' not in m['header']:
            continue
        else:
            msg_type = m['header']['msg_type']
            
        s = None
        if msg_type == 'status':
            if m['content']['execution_state'] == 'idle':
                newprompt = True
            else:
                newprompt = False
        elif msg_type == 'stream':
            s = strip_color_escapes(m['content']['data'])
        elif msg_type == 'pyout':
            s = m['content']['data']['text/plain']
        elif msg_type == 'pyin':
            # don't want to print the input twice
            continue
        elif msg_type == 'pyerr':
            c = m['content']
            s = "ERROR >>\n" + "\n".join(map(strip_color_escapes,c['traceback']))
            s += c['ename'] + ": " + c['evalue']
            s += "\n<< ERROR"
        
        if s: # then update the vim-ipython buffer with the formatted text
            if s.find('\n') == -1: # then use ugly unicode workaround from 
                # http://vim.1045645.n5.nabble.com/Limitations-of-vim-python-interface-with-respect-to-character-encodings-td1223881.html
                if isinstance(s,unicode):
                    s = s.encode(vim_encoding)
                vib.append(s)
                if debugging:
                    vib.append('using unicode workaround')
            else:
                try:
                    vib.append(s.splitlines())
                except:
                    vib.append([l.encode(vim_encoding) for l in s.splitlines()])
        
    # move to the vim-ipython (so that the autocommand can scroll down)
    if in_vim_ipython():
        if newprompt:
            vib.append('>> ')
            vim.command('normal G')
            vim.command('startinsert!')
    else:
        vim.command('drop vim-ipython.py')
        if newprompt:
            vib.append('>> ')
        # then get out of insert mode and go back to the previous location
        vim.command('exe "normal \<C-w>p"')
    # make an arbitrary command, so that the cursorhold autocommand will be triggered again
    # vim.command("call feedkeys('f\e')")
            
def get_child_msg(msg_id):
    # XXX: message handling should be split into its own process in the future
    while True:
        # get_msg will raise with Empty exception if no messages arrive in 5 second
        m= km.shell_channel.get_msg(timeout=5)
        if m['parent_header']['msg_id'] == msg_id:
            break
        else:
            #got a message, but not the one we were looking for
            echo('skipping a message on shell_channel','WarningMsg')
    return m
            
def print_prompt(prompt,msg_id=None):
    global show_execution_count
    if show_execution_count and msg_id:
        # wait to get message back from kernel
        try:
            child = get_child_msg(msg_id)
            count = child['content']['execution_count']
            echo(">> %s" % prompt)
        except Empty:
            echo(">> %s (no reply from IPython kernel)" % prompt)
    else:
        echo(">> %s" % prompt)

def with_subchannel(f,*args):
    "conditionally monitor subchannel"
    def f_with_update(*args):
        try:
            f(*args)
            if monitor_subchannel:
                update_subchannel_msgs()
        except AttributeError: #if km is None
            echo("not connected to IPython", 'Error')
    return f_with_update

@with_subchannel
def run_this_file():
    msg_id = send("get_ipython().magic(u'run %s %s')" % (run_flags, repr(vim.current.buffer.name)[1:-1]))

@with_subchannel
def run_this_line():
    # don't send blank lines
    if vim.current.line != '':
        msg_id = send(vim.current.line)

@with_subchannel
def run_command(cmd):
    msg_id = send(cmd)

@with_subchannel
def run_these_lines():
    r = vim.current.range
    lines = "\n".join(vim.current.buffer[r.start:r.end+1])
    msg_id = send(lines)
    # reselect the previously highlighted block
    vim.command("normal gv")
    if not reselect:
        vim.command("normal ")

# TODO: Add ability to run a selection

def set_pid():
    """
    Explicitly ask the ipython kernel for its pid
    """
    global km, pid
    lines = '\n'.join(['import os', '_pid = os.getpid()'])
    msg_id = km.shell_channel.execute(lines, silent=True, user_variables=['_pid'])

    # wait to get message back from kernel
    try:
        child = get_child_msg(msg_id)
    except Empty:
        echo("no reply from IPython kernel")
        return

    pid = int(child['content']['user_variables']['_pid'])
    return pid

def shutdown():
    
    if is_vim_ipython_open(): # close the window
        vim.command('drop vim-ipython.py')
        vim.command('quit')
    # wipe the buffer
    vim.command('bw vim-ipython.py')
    km.kill_kernel()

def interrupt_kernel_hack():
    """
    Sends the interrupt signal to the remote kernel.  This side steps the
    (non-functional) ipython interrupt mechanisms.
    Only works on posix.
    """
    global pid
    import signal
    import os
    if pid is None:
        # Avoid errors if we couldn't get pid originally,
        # by trying to obtain it now
        pid = set_pid()

        if pid is None:
            echo("cannot get kernel PID, Ctrl-C will not be supported")
            return
    echo("KeyboardInterrupt (sent to ipython: pid " +
        "%i with signal %i)" % (pid, signal.SIGINT),"Operator")
    try:
        os.kill(pid, signal.SIGINT)
    except OSError:
        echo("unable to kill pid %d" % pid)
        pid = None

def dedent_run_this_line():
    vim.command("left")
    run_this_line()
    vim.command("silent undo")

def dedent_run_these_lines():
    r = vim.current.range
    shiftwidth = vim.eval('&shiftwidth')
    count = int(vim.eval('indent(%d+1)/%s' % (r.start,shiftwidth)))
    vim.command("'<,'>" + "<"*count)
    run_these_lines()
    vim.command("silent undo")

def startup():
    vim.command('!start /min ipython qtconsole')
    vim.command('sleep 1')
    origin_dir = vim.current.buffer.name
    setup_vib()
    km_from_string()
    # km.shell_channel.execute('os.chdir("' + origin_dir + '")', silent=True,


    # Update the vim-ipython shell when the cursor is not moving, or vim regains focus
    vim.command("set updatetime=333") # will ping 3 times  a second
    vim.command("au CursorHold *.py :python update_subchannel_msgs()")
    vim.command("au FocusGained *.py :python update_subchannel_msgs()")
    
EOF

" MAPPINGS
noremap <silent> <F5> :w<CR>:python run_this_file()<CR><ESC>
noremap <silent> K :py get_doc_buffer()<CR>
vnoremap <silent> <F9> :py run_these_lines()<CR><ESC>j
nnoremap <silent> <F9> :py run_this_line()<CR><ESC>j
noremap <silent> <F12> :drop vim-ipython.py<CR>
noremap <silent> <C-F12> :py startup()<CR>
" noremap <silent> <S-F12> :shutdown()<CR>
"inoremap <silent> <S-CR> <ESC>:set nohlsearch<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>Go<ESC>o
"nnoremap <silent> <S-CR> :set nohlsearch<CR>/^\n<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>j
"nnoremap <silent> <C-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>
"" same as above, except moves to the next cell
"nnoremap <silent> <C-S-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>N:let @/ = ""<CR>:set hlsearch<CR>

command! -nargs=* IPython :py km_from_string("<args>")
command! -nargs=0 IPythonClipboard :py km_from_string(vim.eval('@+'))
command! -nargs=0 IPythonXSelection :py km_from_string(vim.eval('@*'))
command! -nargs=0 IPythonInterrupt :py interrupt_kernel_hack()


