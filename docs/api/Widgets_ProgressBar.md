# ProgressBar

*ProgressBar*

<dl>
    <dl><tt>new operation</tt><big>(</big><em>int width, int totalSteps = 100</em><big>)</big></dl>
    <dd>Constructs progress bar.</dd>

    <dl><tt>style</tt><big>(</big><em>string filled = "=", string unfilled = ".", string arrow = ">"</em><big>)</big></dl>
    <dd>Sets bar style.</dd>

    <dl><tt>progress</tt><big>(</big><em>int step</em><big>)</big></dl>
    <dd>Changes bar state. If step reaches totalSteps, newline-char will be added.</dd>
</dl>
