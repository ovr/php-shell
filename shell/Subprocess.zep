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
 * Class Subprocess.
 */
class Subprocess {
	/**
	 * Runs a system command.
	 */
	static public function call(string! args, resource stdin = fopen("php://memory", "r"), resource stdout = null, resource stderr = null, shell = false) -> int {
		var proc;
		array pipes = [];
		if is_null(stdin) {
			let stdin = ["pipe", "r"];
		}
		if is_null(stdout) {
			let stdout = ["pipe", "w"];
		}
		if is_null(stderr) {
			let stderr = ["pipe", "w"];
		}

		let proc = proc_open(args, [
			0: stdin,
			1: stdout,
			2: stderr
		], pipes);
		return proc_close(proc);
	}
}
