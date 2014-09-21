# ProgressBar

*ProgressBar*

<dl>
    <dt><tt>new operation</tt><big>(</big><em>int width, int totalSteps = 100</em><big>)</big></dt>
    <dd>Constructs progress bar.</dd>

    <dt><tt>style</tt><big>(</big><em>string filled = "=", string unfilled = ".", string arrow = ">"</em><big>)</big></dt>
    <dd>Sets bar style.</dd>

    <dt><tt>progress</tt><big>(</big><em>int step</em><big>)</big></dt>
    <dd>Changes bar state. If step reaches totalSteps, newline-char will be added.</dd>
</dl>
