# Subprocess

*Subprocess*

## Class members

<dl>
    <dt><tt>call</tt><big>(</big><em>string args, resource stdin = null, resource stdout = null, resource stderr = null</em><big>)</big></dt>
    <dd>Runs a system command.</dd>
</dl>

## Object members

<dl>
    <dt><tt>returnCode</tt>: int</dt>
    <dt><tt>stdin</tt> : resource</dt>
    <dt><tt>stdout</tt> : resource</dt>
    <dt><tt>stderr</tt> : resource</dt>
    <dt><tt>pid</tt> : int</dt>
    
    <dt><tt>new operation</tt><big>(</big><em>string args</em><big>)</big></dt>
    <dd>Creates a subprocess object.</dd>
    
    <dt><tt>poll</tt><big>()</big></dt>
    <dd>Check if child process has terminated. Set and return returnCode attribute.</dd>
    
    <dt><tt>wait</tt><big>()</big></dt>
    <dd>Wait for child process to terminate. Set and return returnCode attribute.</dd>
    
    <dt><tt>communicate</tt><big>(</big><em>string input = null</em><big>)</big></dt>
    <dd>Interact with process: Send data to stdin. Read data from stdout and stderr, until end-of-file is reached. Wait for process to terminate. The optional input argument should be a string to be sent to the child process, or None, if no data should be sent to the child.</dd>
    
    <dt><tt>send_signal</tt><big>(</big><em>int signal</em><big>)</big></dt>
    <dd>Sends the signal signal to the child.</dd>
    
    <dt><tt>terminate</tt><big>()</big></dt>
    <dd>Stop the child.</dd>
    
    <dt><tt>kill</tt><big>()</big></dt>
    <dd>Kills the child.</dd>
</dl>
