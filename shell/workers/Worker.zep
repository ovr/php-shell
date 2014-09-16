/**
 * Shell extension.
 *
 * @author Sergei Vanyushin <wapmorgan@gmail.com>
 * @link https://github.com/wapmorgan/Shell
 * @license Apache License 2.0
 * @license http://www.apache.org/licenses/LICENSE-2.0.html
 */
namespace Shell\Workers;

/**
 * Class Worker.
 */
class Worker {
	public state = WorkerState::FREE;
	public functionName;
	private subprocessId = 0;

	/**
	 * Checks worker function.
	 */
	public function init() {
		if unlikely this->functionName === null {
			throw new \Exception("Worker.functionName should contain working function name.");
		}
	}

	/**
	 * Wait for working function to exit.
	 */
	public function finalize() {
		var status = null;
		if this->subprocessId > 0 {
			pcntl_waitpid(this->subprocessId, status);
		}
	}

	/**
	 * Daemonizes worker function and lets it work.
	 */
	public function forkAndWork(<WorkerContext> context) {
		var pid;
		let pid = pcntl_fork();
		if pid > 0 {
			return;
		} else {
			let this->subprocessId = getmypid();
			call_user_func(this->functionName, context);
			exit(0);
		}
	}

	/**
	 * Handles signal.
	 */
	public function onSignal(int! signal) {
		if this->subprocessId > 0 {
			switch (signal) {
				case \Shell\PosixSignals::SIGKILL:
					posix_kill(this->subprocessId, \Shell\PosixSignals::SIGKILL);
				break;
			}
		}
	}
}
