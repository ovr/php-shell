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

	/**
	 * Registers stream in internal streams pool.
	 */
	public function registerStream(string stream, resource streamResource) {
		let this->streams[stream] = streamResource;
	}

	/**
	 * Unregisters stream from internal streams pool.
	 */
	public function unregisterStream(string stream) {
		if isset(this->streams[stream]) {
			unset(this->streams[stream]);
		}
	}

	/**
	 * Sends a message to debug output stream.
	 */
	public function debug(string message) {
		this->write("DEBUG", message);
	}

	/**
	 * Sends a message to default output stream.
	 */
	public function output(string message) {
		this->write("OUTPUT", message);
	}

	/**
	 * Sends a message to error output stream.
	 */
	public function error(string message) {
		this->write("ERROR", message);
	}

	/**
	 * Sends a message to one of internal streams.
	 * If according stream is not registered, message goes to STDIN or STDERR (depending on result of `$stream == 'ERROR'`).
	 */
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
