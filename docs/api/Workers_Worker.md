# Worker

*Worker*

<dl>
	<dt><tt>state</tt></dt>
	<dd>Worker state. Can be <code>WorkerState::FREE</code> or <code>WorkerState::RUNNING</code></dd>

	<dt><tt>functionName</tt></dt>
	<dd>Contains worker function name. <a href="WorkerContext.md">WorkerContext</a> will be passed to function.</dd>

	<dt><tt>init()</tt><big>()</big></dt>
	<dd>Checks worker function.</dd>

	<dt><tt>finalize()</tt><big>()</big></dt>
	<dd>Wait for working function to exit.</dd>

	<dt><tt>forkAndWork</tt><big>(</big><em>WorkerContext context</em><big>)</big></dt>
	<dd>Daemonizes worker function and lets it work.</dd>

	<dt><tt>onSignal</tt><big>(</big><em>int signal</em><big>)</big></dt>
	<dd>Handles signal.</dd>
</dl>
