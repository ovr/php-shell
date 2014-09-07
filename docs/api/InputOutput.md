# InputOutput

*InputOutput*

<dl>
	<dt><tt>requestUserInput</tt><big>()</big></dt>
	<dd>Gets input string</dd>

	<dt><tt>buffer</tt><big>(</big><em>string text</em><big>)</big></dt>
	<dt><tt>bufferVar</tt><big>(</big><em>variable</em><big>)</big></dt>
	<dd>Collects anything in buffer</dd>

	<dt><tt>flushBuffer</tt><big>()</big></dt>
	<dd>Flushes buffer to stdout.</dd>

	<dt><tt>registerStream</tt><big>(<em>string stream, resource streamResource</em><big>)</big></big>
	<dd>Registers stream in internal streams pool.</dd>

	<dt><tt>unregisterStream</tt><big>(</big><em>string stream</em><big>)</big></dt>
	<dd>Unregisters stream from internal streams pool.</dd>

	<dt><tt>debug</tt><big>(</big><em>string message</em><big>)</big></dt>
	<dt><tt>output</tt><big>(</big><em>string message</em><big>)</big></dt>
	<dt><tt>error</tt><big>(</big><em>string message</em><big>)</big></dt>
	<dd>Sends a message to:
	- debug output stream
	- default output stream
	- error output stream</dd>

	<dt><tt>write</tt><big>(</big><em>string stream, string message</em><big>)</big></dt>
	<dd>Sends a message to one of internal streams.<br />
	If according stream is not registered, message goes to STDIN or STDERR (depending on result of `$stream == 'ERROR'`).</dd>

</dl>
