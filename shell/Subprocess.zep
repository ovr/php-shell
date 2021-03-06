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
	public returnCode;
	private args;
	private process;
	public stdin;
	public stdout;
	public stderr;
	public pid;


	/**
	 * Runs a system command.
	 */
	static public function call(string! args, stdin = null, stdout = null, stderr = null) -> int {
		var process;
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

		let process = proc_open(args, [
			0: stdin,
			1: stdout,
			2: stderr
		], pipes);
		if process == false {
			return -2;
		}
		return proc_close(process);
	}

	/**
	 * Creates a subprocess object
	 */
	public function __construct(string! args){
		let this->args = args;
		this->start();
	}

	/**
	 * Starts program
	 */
	protected function start() -> void {
		array pipes = [];
		let this->process = proc_open(this->args, [
			0: ["pipe", "r"],
			1: ["pipe", "w"],
			2: ["pipe", "w"]
		], pipes);
		let this->stdin = pipes[0],
			this->stdout = pipes[1],
			this->stderr = pipes[2];

		var status; let status = proc_get_status(this->process);

		let this->pid = status["pid"];
	}

	/**
	 * Check if child process has terminated. Set and return returnCode attribute.
	 */
	public function poll() -> int|boolean {
		var status; let status = proc_get_status(this->process);
		if status["running"] === false {
			let this->returnCode = (int)status["exitcode"];
			return this->returnCode;
		}
		return false;
	}

	/**
	 * Wait for child process to terminate. Set and return returnCode attribute.
	 */
	public function wait() -> int {
		var status; let status = proc_get_status(this->process);
		while (status["running"])
		{
			sleep(1);
			let status = proc_get_status(this->process);
		}
		this->close();
		let this->returnCode = (int)status["exitcode"];
		return (int)status["exitcode"];
	}

	/**
	 * Interact with process: Send data to stdin. Read data from stdout and stderr, until end-of-file is reached. Wait for process to terminate. The optional input argument should be a string to be sent to the child process, or None, if no data should be sent to the child.
	 */
	public function communicate(string input = null) -> array {
		fwrite(this->stdin, input);
		fclose(this->stdin);
		var buffer;
		var output = [null, null];
		while (!feof(this->stdout)) {
			let buffer = fread(this->stdout, 8192);
			if buffer->length === 0 {
				var_dump("debug: eof of stdout reached");
				break;
			}
			let output[0] .= buffer;
		}


		while (!feof(this->stderr)) {
			let buffer = fread(this->stderr, 8192);
			if buffer->length === 0 {
				var_dump("debug: eof of stderr reached");
				break;
			}
			let output[1] .= buffer;
		}
		this->close();
		var_dump(output);
		return output;
	}

	/**
	 * Sends the signal signal to the child.
	 */
	public function send_signal(int! signal) {
		proc_terminate(this->process, signal);
	}

	/**
	 * Stop the child.
	 */
	public function terminate() {
		proc_terminate(this->process, PosixSignals::SIGTERM);
	}

	/**
	 * Kills the child.
	 */
	public function kill() {
		proc_terminate(this->process, PosixSignals::SIGKILL);
	}

	/**
	 * Closes process on destruction
	 */
	public function __destruct() {
		if is_null(this->returnCode) {
			this->close();
		}
	}

	/**
	 * Closes process resource
	 */
	private function close() {
		fclose(this->stdin);
		fclose(this->stdout);
		fclose(this->stderr);
		proc_close(this->process);
	}
}
