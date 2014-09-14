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
 * Class AbstractDaemon.
 */
abstract class AbstractDaemon extends AbstractScript {

	/**
	 * Daemonizes current script.
	 */
	protected function daemonize() -> void {
		var child_pid;
		let child_pid = pcntl_fork();
		if child_pid > 0 {
			exit(0);
		}
		posix_setsid();
	}

	/**
	 * Check if passed pid-file present and there's running daemon by its pid from file
	 * @param string pidFile Path to pid-file
	 * @return boolean
	 */
	protected function isDaemonRunning(string pidFile) -> boolean {
		if file_exists(pidFile) {
			var pid;
			let pid = file_get_contents(pidFile);
			if posix_kill(pid, 0) {
				return true;
			} else {
				return !unlink(pidFile);
			}
		}
		return false;
	}
}
