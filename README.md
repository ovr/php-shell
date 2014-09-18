Shell php module - framework for shell scripts.
---
[![Build Status](https://travis-ci.org/wapmorgan/php-shell.svg)](http://travis-ci.org/wapmorgan/php-shell)
[![Latest Stable Version](https://poser.pugx.org/wapmorgan/php-shell/v/stable.png)](https://packagist.org/packages/wapmorgan/php-shell)
[![Total Downloads](https://poser.pugx.org/wapmorgan/php-shell/downloads.png)](https://packagist.org/packages/wapmorgan/php-shell)
[![License](https://poser.pugx.org/wapmorgan/php-shell/license.svg)](https://packagist.org/packages/wapmorgan/php-shell)

Shell is a php extension aimed to ease creation command-line php scripts by providing most usable functionalities.

### Installation:

**For Developing:**

1. Install Zephir (http://zephir-lang.com/install.html)
2. run `zephir build`
3. enable extension
```
echo "extension=shell.so" > /etc/php5/conf.d/shell.ini
```

**For users:**

1. clone [wapmorgan@php-shell-sources](https://github.com/wapmorgan/php-shell-sources/)
`git clone https://github.com/wapmorgan/php-shell-sources.git`
2. phpize
	`phpize`
3. configure
	`./configure`
3. make
	`make`
4. install
	`make install`
5. enable
	`php5enmod shell`

## Introducing
To make a shell script, you need:

1. **Create `Shell` instance (\Shell\Shell)**.
2. **Register handler (php function, class method or closure)**. **Possible handler - any valid callback**, that receives `Shell` instance as the 1st argument and array containing script `arguments` as the 2nd argument.
3. **Register script options**. **Possible options types**:

	|   Option class   |    cmdline example    |                             phpcode example                             |
	|------------------|-----------------------|-------------------------------------------------------------------------|
	| FlagOption       | --version, --help     | `new FlagOption('h:help', 'showHelp')`                                  |
	| MultiValueOption | file1 file2 file3     | `new MultiValueOption(null, 'files')`                                   |
	| StringOption     | --outputFile=/tmp/log | `new StringOption('o:outputFile', 'outputFile')`                        |
	| SwitchOption     | --mode=streams        | `new SwitchOption('m:mode', 'mode', array('colors', 'curl', 'streams))` |

4. **Write handler**. You can extend **AbstractScript** or **AbstractDaemon**:

	* **\Shell\AbstractScript**:
		- `run(<Shell> shell, array arguments = [])`
		- `registerStreams(array streams, <InputOutput> io)`
	* **\Shell\AbstractDaemon** -
		- `daemonize()`
		- `isDaemonRunning(string pidFile)`

### Examples
```php
<?php
use \Shell\Shell;

$shell = new Shell;
$shell->registerHandler(/* handler callback here */);
$shell->registerOptions(array(
	// ... script options here
));
$shell->process();
```

**Handler** can be any valid callback, for example:
```php
$shell->registerHandler(function (Shell $shell, array $arguments) {
	...
});
```

More complex examples of usage are collected [here](https://github.com/wapmorgan/shell-scripts).

#### API
**\\Shell**:

1. [AbstractDaemon](docs/api/AbstractDaemon.md)
2. [AbstractOption](docs/api/AbstractOption.md)
3. [AbstractScript](docs/api/AbstractScript.md)
4. [Curl](docs/api/Curl.md)
5. [CurlSettingsContainer](docs/api/CurlSettingsContainer.md)
6. [DependencyException](docs/api/DependencyException.md)
7. [FlagOption](docs/api/FlagOption.md)
8. [InputOutput](docs/api/InputOutput.md)
9. [MultiValueOption](docs/api/MultiValueOption.md)
10. [NotImplementedException](docs/api/NotImplementedException.md)
11. [Shell](docs/api/Shell.md)
12. [ShellException](docs/api/ShellException.md)
13. [StringOption](docs/api/StringOption.md)
14. [Subprocess](docs/api/Subprocess.md)
15. [SwitchOption](docs/api/SwitchOption.md)

**\\Shell\\Workers**:
Introduction to workers in [docs/book/workers](docs/book/workers.md).

1. [Worker](docs/api/Workers_Worker.md)
2. [WorkerContext](docs/api/Workers_WorkerContext.md)
3. [WorkerState](docs/api/Workers_WorkerState.md)
4. [WorkersPool](docs/api/Workers_WorkersPool.md)

[Full classmap listed in classmap.md](docs/api/classmap.md).

#### Why should I use the `Shell`?
Because it's faster, safer and well-documented.

1. `Shell` is beeing compiled against C+ compiler, so it's fast.
2. `Shell` is beeing checked by Zephir parser and C++ parser, so it's safe.
3. Projects written in Zephir ain't supported by PhpDoc, so we try to make useful and simple documentation.

#### Author
Sergei Vanyushin (also known as wapmorgan)
