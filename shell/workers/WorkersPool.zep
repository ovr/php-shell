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
 * Class WorkersPool.
 */
class WorkersPool {
	private pool = [];

	/**
	 * Adds few workers.
	 */
	public function addWorkers(string workerClass, int num) -> boolean {
		if unlikely !class_exists(workerClass) {
			throw new \Exception("Worker class '". workerClass ."' is not available!");
		}
		if 
		var worker;
		while (num-- > 0)
		{
			let worker = this->newWorker(workerClass);
			array_push(this->pool, worker);
		}
		return true;
	}

	/**
	 * Creates a new worker and returns.
	 */
	private function newWorker(string workerClass) -> <Worker> {
		var worker;
		let worker = new {workerClass};
		worker->init();
		return worker;
	}

	/**
	 * Returns count of active workers.
	 */
	public function getCountWorkers() -> int {
		return count(this->pool);
	}

	/**
	 * Deletes N of workers.
	 */
	public function delWorkers(int num) -> int {
		var worker;
		while (num-- > 0)
		{
			if count(this->pool) == 0 {
				break;
			}
			let worker = array_pop(this->pool);
			worker->finalize();
			unset(worker);
		}
		return true;
	}

	/**
	 * Send signal to workers.
	 */
	public function signal(int! signal) {
		var worker;
		for worker in this->pool {
			worker->onSignal(signal);
		}
	}

	/**
	 * Closes all workers.
	 */
	public function closeAll() -> void {
		var worker;
		for worker in this->pool {
			if worker->state === WorkerState::FREE {
				worker->finalize();
				unset();
			}
		}
	}

	/**
	 * Returns count of free workers.
	 */
	public function getCountFreeWorkers() -> int {
		int count = 0;
		var worker;
		for worker in this->pool {
			if worker->state === WorkerState::FREE {
				count++;
			}
		}
		return count;
	}

	/**
	 * Sends work to a free worker
	 */
	public function dispatchWork(<WorkerContext> context) -> boolean {
		boolean worked = false;
		var worker;
		for worker in this->pool {
			if worker->state === WorkerState::FREE {
				let worker->state = WorkerState::RUNNING;
				let worked = true;
				worker->work(context);
				let worker->state = WorkerState::FREE;
				break;
			}
		}
		return worked;
	}
}
