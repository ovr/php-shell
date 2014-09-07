/**
 * Shell extension.
 *
 * @author Sergei Vanyushin <wapmorgan@gmail.com>
 * @link https://github.com/wapmorgan/Shell
 * @license Apache License 2.0
 * @license http://www.apache.org/licenses/LICENSE-2.0.html
 */
namespace Shell;

/**
 * Class InputOutput.
 */
class InputOutput {
	private buffer = null;
	private streams = [];

	/**
	 * Checks requirements.
	 */
	public function __construct() {
		if unlikely !defined("STDIN") {
			define("STDIN", fopen("php://stdin", "r"), false);
		}
		if unlikely !defined("STDOUT") {
			define("STDOUT", fopen("php://stdout", "w"), false);
		}
		if unlikely !defined("STDERR") {
			define("STDERR", fopen("php://stderr", "w"), false);
		}
	}

	/**
	 * Gets input string
	 */
	public function requestUserInput() {
		this->resetInputBuffer();
		stream_set_blocking(STDIN, 1);
		return rtrim(fgets(STDIN));
	}

	/**
	 * Resets input buffer
	 */
	private function resetInputBuffer() {
		stream_set_blocking(STDIN, 0);
		while fgets(STDIN) !== false {};
	}

	/**
	 * Collects anything in buffer
	 */
	public function buffer(string text) {
		let this->buffer = this->buffer.text;
	}
	public function bufferVar(variable) {
		this->buffer(var_export(variable, true));
	}

	/**
	 * Flushes buffer to stdout.
	 */
	public function flushBuffer() {
		echo this->buffer;
		let this->buffer = null;
	}

	public function registerStream(string stream, resource streamResource) {
		let this->streams[stream] = streamResource;
	}

	public function unregisterStream(string stream) {
		if isset(this->streams[stream]) {
			unset(this->streams[stream]);
		}
	}

	public function debug(string message) {
		this->write("DEBUG", message);
	}

	public function output(string message) {
		this->write("OUTPUT", message);
	}

	public function error(string message) {
		this->write("ERROR", message);
	}

	public function write(string stream, string message) {
		var streamResource;
		if fetch streamResource, this->streams[stream] {
			fwrite(streamResource, message);
		} else {
			if stream == "ERROR" {
				let streamResource = STDERR;
			} else {
				let streamResource = STDOUT;
			}
			fwrite(streamResource, message);
		}
	}
}
