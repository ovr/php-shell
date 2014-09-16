Shell Zephir extension
---
[![Build Status](https://travis-ci.org/wapmorgan/php-shell.svg)](http://travis-ci.org/wapmorgan/php-shell)
[![Latest Stable Version](https://poser.pugx.org/wapmorgan/php-shell/v/stable.png)](https://packagist.org/packages/wapmorgan/php-shell)
[![Total Downloads](https://poser.pugx.org/wapmorgan/php-shell/downloads.png)](https://packagist.org/packages/wapmorgan/php-shell)
[![License](https://poser.pugx.org/wapmorgan/php-shell/license.svg)](https://packagist.org/packages/wapmorgan/php-shell)

Shell is a php extension aimed to ease creation command-line php-scripts.

### Installation:

1. Install Zephir (http://zephir-lang.com/install.html)
2. run `zephir build`
3. enable extension
```
echo "extension=shell.so" > /etc/php5/conf.d/shell.ini
```
## Introducing
To make a shell script, you need:

1. **Create `Shell` instance (\Shell\Shell)**.
2. **Register handler (php function, class method or closure)**. **Possible handlers - any valid callback**, that receives `Shell` instance as the 1st argument and array containing script `arguments` as the 2nd argument.
3. **Register script options**. **Possible options types**:

	|   Option class   |    cmdline example    |                             phpcode example                             |
	|------------------|-----------------------|-------------------------------------------------------------------------|
	| FlagOption       | --version, --help     | `new FlagOption('h:help', 'showHelp')`                                  |
	| MultiValueOption | file1 file2 file3     | `new MultiValueOption(null, 'files')`                                   |
	| StringOption     | --outputFile=/tmp/log | `new StringOption('o:outputFile', 'outputFile')`                        |
	| SwitchOption     | --mode=streams        | `new SwitchOption('m:mode', 'mode', array('colors', 'curl', 'streams))` |

4. **Write handler**. Also, you can extend **AbstractScript** or **AbstractDaemon**:

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
2. [AbstractScript](docs/api/AbstractScript.md)
3. [Curl](docs/api/Curl.md)
4. [CurlSettingsContainer](docs/api/CurlSettingsContainer.md)
5. [DependencyException](docs/api/DependencyException.md)
6. [FlagOption](docs/api/FlagOption.md)
7. [InputOutput](docs/api/InputOutput.md)
8. [MultiValueOption](docs/api/MultiValueOption.md)
9. [NotImplementedException](docs/api/NotImplementedException.md)
10. [Shell](docs/api/Shell.md)
11. [ShellException](docs/api/ShellException.md)
12. [StringOption](docs/api/StringOption.md)
13. [Subprocess](docs/api/Subprocess.md)
14. [SwitchOption](docs/api/SwitchOption.md)

**\\Shell\\Workers**:
1. [Worker](docs/api/workers/Worker.md)
2. [WorkerContext](docs/api/workers/WorkerContext.md)
3. [WorkerState](docs/api/workers/WorkerState.md)
4. [WorkersPool](docs/api/workers/WorkersPool.md)


#### Author
Sergei Vanyushin (also known as wapmorgan)
