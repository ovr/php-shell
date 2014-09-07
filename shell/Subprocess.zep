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
	static public function call(string! args, stdin = null, stdout = null, stderr = null, shell = false) -> int {
		var proc;
		array pipes = [];
		if is_null(stdin) || !is_resource(stdin) {
			let stdin = ["pipe", "r"];
		}
		if is_null(stdout) || !is_resource(stdout) {
			let stdout = ["pipe", "w"];
		}
		if is_null(stderr) || !is_resource(stderr) {
			let stderr = ["pipe", "w"];
		}

		let proc = proc_open(args, [
			0: stdin,
			1: stdout,
			2: stderr
		], pipes);
		if proc == false {
			return -2;
		}
		return proc_close(proc);
	}
}
