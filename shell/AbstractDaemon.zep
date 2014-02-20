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
	 * @param callable callback Parent thread callback.
	 */
	protected function daemonize(callback) -> void {
		if unlikely !is_callable(callback) {
			throw new \InvalidArgumentException("Value ".callback." (".gettype(callback).") is not a valid callable thing.");
		}

		var child_pid;
		let child_pid = pcntl_fork();
		if child_pid > 0 {
			call_user_func(callback);
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
