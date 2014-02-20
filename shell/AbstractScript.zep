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
 * Class AbstractScript.
 */
abstract class AbstractScript {
	protected shell;
	protected arguments;

	/**
	 * Starts script.
	 * @param Shell shell a Shell instance
	 * @param array arguments Parsed script arguments
	 */
	public function run(<Shell> shell, array arguments = []) -> void {
		let this->shell = shell, this->arguments = arguments;
	}

	/**
	 * Registers streams.
	 * @param array streams Streams. Keys are streams, values are fopen() resources
	 * @param InputOutput io InputOutput instance
	 */
	protected function registerStreams(array streams, <InputOutput> io) -> void {
		var stream, streamResource;
		for stream, streamResource in streams {
			io->registerStream(stream, streamResource);
		}
	}
}
