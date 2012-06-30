" Vim integration with IPython 0.11+
"
" A two-way integration between Vim and IPython.
"
" Using this plugin, you can send lines or whole files for IPython to execute,
" and also get back object introspection and word completions in Vim, like
" what you get with: object?<enter> object.<tab> in IPython
"
" -----------------
" Quickstart Guide:
" -----------------
" Start ipython qtconsole and copy the connection string.
" Source this file, which provides new IPython command
"   :source ipy.vim
"   :IPythonClipboard
"   (or :IPythonXSelection if you're using X11 without having to copy)
"
" written by Paul Ivanov (http://pirsquared.org)
"
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
vim_encoding=vim.eval('&encoding') or 'utf-8'

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

def km_from_string(s=''):
    """create kernel manager from IPKernelApp string
    such as '--shell=47378 --iopub=39859 --stdin=36778 --hb=52668' for IPython 0.11
    or just 'kernel-12345.json' for IPython 0.12
    """
    from os.path import join as pjoin
    from IPython.zmq.blockingkernelmanager import BlockingKernelManager, Empty
    from IPython.config.loader import KeyValueConfigLoader
    from IPython.zmq.kernelapp import kernel_aliases
    global km, send, Empty

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

    def send(cmds, *args, **kargs):
        """ Send commands to ipython kernel.

        Append a print statement so that we know when IPython
        is done processing the commands. """

        km.shell_channel.execute(cmds + "\nprint('##done')", *args, **kargs)
        return

    # SETUP VIM-IPYTHON BUFFER
    vim.command("rightbelow vnew vim-ipython")
    vim.current.buffer[0] == '>> '
    vim.command("startinsert!")
    vim.command("setl nonumber showbreak=\ \ \ ")
    vim.command("setl bufhidden=hide buftype=nofile ft=python noswf ")
    vim.command("hi Green ctermfg=Green guifg=#00ED45")
    vim.command("hi Red ctermfg=Red guifg=Red")
    vim.command("syn match Green /^>>/")
    vim.command("syn match Red /^<</")
    vim.command("syn region Red start=/^ERROR >>$/ end=/^<< ERROR$/")
    vim.command("inoremap <buffer> <s-cr> <ESC>:py shift_enter_at_prompt()<CR>")
    vim.command("inoremap <buffer> <cr> <ESC>:py enter_at_prompt()<CR>")
    # ctrl-C gets sent to the IPython process as a signal on POSIX
    vim.command("noremap <buffer>  :IPythonInterrupt<cr>")
    # add and auto command, so that the cursor always moves to the end
    # upon entereing the vim-ipython buffer
    vim.command('au BufEnter <buffer> exe "normal G" | startinsert!')

    set_pid()
    return km

def shift_enter_at_prompt():
    linen = -1
    b = vim.current.buffer
    cmds = b[-1][3:]
    while not b[linen].startswith('>> '):
        cmds = b[linen][3:] + '\n' + cmds
        linen -= linen
    send(cmds)

def enter_at_prompt():
    b = vim.current.buffer
    lastline = b[-1]
    b.append("bottom")
    if lastline.startswith('>> '):
        ws = re.match(r'^([ \t])*', lastline)
        if ws:
            ws = ws.group(1)
        b[-1] = ws
    else:
        b[-1] = '   '
    vim.command('normal G')
    vim.command('startinsert!')

def echo(arg,style="Question"):
    try:
        vim.command("echohl %s" % style)
        vim.command("echom \"%s\"" % arg.replace('\"','\\\"'))
        vim.command("echohl None")
    except vim.error:
        print "-- %s" % arg

def disconnect():
    "disconnect kernel manager"
    # XXX: make a prompt here if this km owns the kernel
    pass

def get_doc(word):
    if km is None:
        return ["Not connected to IPython, cannot query: %s" % word]
    msg_id = km.shell_channel.object_info(word)
    doc = get_doc_msg(msg_id)
    # get around unicode problems when interfacing with vim
    return [d.encode(vim_encoding) for d in doc]

# from http://serverfault.com/questions/71285/in-centos-4-4-how-can-i-strip-escape-sequences-from-a-text-file
strip = re.compile('\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]')
def strip_color_escapes(s):
    return strip.sub('',s)

def get_doc_msg(msg_id):
    n = 13 # longest field name (empirically)
    b=[]
    try:
        content = get_child_msg(msg_id)['content']
    except Empty:
        # timeout occurred
        return ["no reply from IPython kernel"]

    if not content['found']:
        return b

    for field in ['type_name','base_class','string_form','namespace',
            'file','length','definition','source','docstring']:
        c = content.get(field,None)
        if c:
            if field in ['definition']:
                c = strip_color_escapes(c).rstrip()
            s = field.replace('_',' ').title()+':'
            s = s.ljust(n)
            if c.find('\n')==-1:
                b.append(s+c)
            else:
                b.append(s)
                b.extend(c.splitlines())
    return b

def get_doc_buffer(level=0):
    # empty string in case vim.eval return None
    word = vim.eval('expand("<cfile>")') or ''

    doc = get_doc(word)
    if len(doc) ==0:
        echo(repr(word)+" not found","Error")
        return
    # documentation buffer name is same as the query made to ipython
    vim.command('new pyhelp')
    vim.command('setlocal nonumber modifiable noro')
    # doc window quick quit keys: 'q' and 'escape'
    vim.command('noremap <buffer> q :q<CR>')
    # Known issue: to enable the use of arrow keys inside the terminal when
    # viewing the documentation, comment out the next line
    vim.command('map <buffer> <Esc> :q<CR>')
    vim.command('noremap <buffer> <silent> K :q<CR>')
    # and uncomment this line (which will work if you have a timoutlen set)
    b = vim.current.buffer

    b[:] = None
    b[:] = doc
    vim.command('setlocal nomodified bufhidden=wipe')
    vim.command('resize %d'% 20)
    vim.command('setlocal syntax=rst')

def is_vim_ipython_open():
    """
    Helper function to let us know if the vim-ipython shell is currently
    visible
    """
    for w in vim.windows:
        if w.buffer.name is not None and w.buffer.name.endswith("vim-ipython"):
            return True
    return False

def get_vim_ipython_buffer():
    """ Return the vim-ipython buffer. """
    for b in vim.buffers:
        if b.name.endswith("vim-ipython"):
            return b
    raise Exception("couldn't find ipython-vim buffer")

def get_vim_ipython_window():
    """ Return the vim-ipython window. """
    for w in vim.windows:
        if w.buffer.name is not None and w.buffer.name.endswith("vim-ipython"):
            return w
    raise Exception("couldn't find ipython-vim window")

def update_subchannel_msgs(debug=False, force=False):
    """
    Grab any pending messages and place them inside the vim-ipython shell.
    This function will do nothing if the vim-ipython shell is not visible,
    unless force=True argument is passed.
    """
    if km is None or (not is_vim_ipython_open() and not force):
        return False
    msgs = km.sub_channel.get_msgs()
    vimipyb = get_vim_ipython_buffer()
    in_vimipyb = vim.current.buffer.name.endswith('vim-ipython')
    newprompt = False

    for m in msgs:
        if 'msg_type' not in m['header']:
            continue
        else:
            msg_type = m['header']['msg_type']
            
        s = ''
        if msg_type == 'status':
            continue
        elif msg_type == 'stream':
            tempstr = strip_color_escapes(m['content']['data'])
            # This lets you know when the ipython kernel is done with the
            # command
            if tempstr.endswith('##done\n'):
                if len(tempstr) > 7:
                    s = tempstr[:-8] + '\n>> '
                else:
                    s = '>> '
                newprompt = True
            else:
                s = tempstr
        elif msg_type == 'pyout':
            s = m['content']['data']['text/plain']
        elif msg_type == 'pyin':
            if not in_vimipyb:
                # remove last input line
                if vimipyb[-1] in ['>> ','>>'] and len(vimipyb) > 1:
                    del vimipyb[-1]
                s = ">> " + m['content']['code'].strip()
                if s.endswith("\nprint('##done')"):
                    s = s[0:-16]
                s = re.sub(r'\n',r'\n   ',s)
        elif msg_type == 'pyerr':
            c = m['content']
            s = "ERROR >>\n" + "\n".join(map(strip_color_escapes,c['traceback']))
            s += c['ename'] + ": " + c['evalue']
            s += "\n<< ERROR"
            # add prompt after an error occurs
            s += "\n>> "
            newprompt = True
        
        # update the vim-ipython buffer with the formatted text
        if s.find('\n') == -1:
            # somewhat ugly unicode workaround from 
            # http://vim.1045645.n5.nabble.com/Limitations-of-vim-python-interface-with-respect-to-character-encodings-td1223881.html
            if isinstance(s,unicode):
                s=s.encode(vim_encoding)
            vimipyb.append(s)
        else:
            try:
                vimipyb.append(s.splitlines())
            except:
                vimipyb.append([l.encode(vim_encoding) for l in s.splitlines()])
        
        if in_vimipyb:
            vim.command('exe "normal G"')
            if newprompt:
                vim.command('startinsert!')
        else:
            cw = vim.current.window
            cc = cw.cursor
            # move to the vim-ipython (so that the autocommand can scroll down)
            vim.command('drop vim-ipython')
            vim.command('normal G')
            # then get out of insert mode and go back to the previous location
            vim.command('drop ' + cw.buffer.name)
            vim.current.window.cursor = cc
    
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

def set_pid():
    """
    Explicitly ask the ipython kernel for its pid
    """
    global km, pid
    lines = '\n'.join(['import os', '_pid = os.getpid()'])
    msg_id = send(lines, silent=True, user_variables=['_pid'])

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
        vim.command('drop vim-ipython')
        vim.command('quit')
    # wipe the buffer
    vim.command('bw vim-ipython')
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
    
EOF

" Update the vim-ipython shell when the cursor is not moving.
" You can change how quickly this happens after you stop moving the cursor by
" setting 'updatetime' (in milliseconds). For example, to have this event
" trigger after 1 second:
"
set updatetime=500
"
" NOTE: This will only be triggered once, after the first 'updatetime'
" milliseconds, *not* every 'updatetime' milliseconds. see :help CursorHold
" for more info.
"
" TODO: Make this easily configurable on the fly, so that an introspection
" buffer we may have opened up doesn't get closed just because of an idle
" event (i.e. user pressed \d and then left the buffer that popped up, but
" expects it to stay there).
au CursorHold * :python update_subchannel_msgs()

" Same as above, but on regaining window focus (mostly for GUIs)
au FocusGained * :python update_subchannel_msgs()

noremap <silent> <F5> :w<CR>:python run_this_file()<CR>
noremap <silent> K :py get_doc_buffer()<CR>
vnoremap <silent> <F9> :py run_these_lines()<CR>
nnoremap <silent> <F9> :py run_this_line()<CR>j
noremap <silent> <F12> :drop vim-ipython<CR>
noremap <silent> <C-F12> :cd %:p:h<CR> :!start /min ipython qtconsole<CR>:sleep 2<CR>:IPython<CR>
noremap <silent> <S-F12> :shutdown()<CR>
inoremap <silent> <S-CR> <ESC>:set nohlsearch<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>Go<ESC>o
nnoremap <silent> <S-CR> :set nohlsearch<CR>/^\n<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>j
nnoremap <silent> <C-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>
" same as above, except moves to the next cell
nnoremap <silent> <C-S-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>N:let @/ = ""<CR>:set hlsearch<CR>


command! -nargs=* IPython :py km_from_string("<args>")
command! -nargs=0 IPythonClipboard :py km_from_string(vim.eval('@+'))
command! -nargs=0 IPythonXSelection :py km_from_string(vim.eval('@*'))
command! -nargs=0 IPythonInterrupt :py interrupt_kernel_hack()


