# WorkersPool

*WorkersPool*

<dl>
	<dt><tt>addWorkers</tt><big>(</big><em>string workerClass, int num</em><big>)</big></dt>
	<dd>Adds few workers.</dd>

	<dt><tt>getCountWorkers</tt><big>()</big></dt>
	<dd>Returns count of active workers.</dd>

	<dt><tt>delWorkers</tt><big>(</big><em>int num</em><big>)</big></dt>
	<dd>Deletes N of workers.</dd>

	<dt><tt>signal</tt><big>(</big><em>int signal</em><big>)</big></dt>
	<dd>Send signal to workers.</dd>

	<dt><tt>closeAll</tt><big>()</big></dt>
	<dd>Closes all workers.</dd>

	<dt><tt>getCountFreeWorkers</tt><big>()</big></dt>
	<dd>Returns count of free workers.</dd>

	<dt><tt>dispatchWork</tt><big>(</big><em>WorkerContext context</em><big>)</big></dt>
	<dd>Sends work to a free worker.</dd>
</dl>
