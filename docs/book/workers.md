# Workers

Workers designed for data processing in the background without slowing down the basic flow of the program.

Creation a new employee is very simple.
Redefine the Worker class and specify the function of the Worker.

```php
use \Shell\Workers\WorkerContext;
class Worker extends \Shell\Workers\Worker {
    public $functionName = 'worker';
}
```

Thereafter, specify body of worker function to be responsible for the execution of background tasks.

```php
function worker(WorkerContext $context) {
    // here code
}
```

To start you need to create a pool of workers and delegate the task to one of the free workers.
For data transmission use container `WorkersContext`.

```php
use \Shell\Workers\WorkerContext;
use \Shell\Workers\WorkersPool;

$pool = new WorkersPool;
$pool->addWorkers('Worker', 4);
$context = new WorkerContext;
$context->valueA = 123;
$context->valueB = fopen('test.log', 'w');
$pool->dispatchWork($context);
```

Here is the full text of our simple example:

```php
use \Shell\Workers\WorkerContext;
use \Shell\Workers\WorkersPool;

class Worker extends \Shell\Workers\Worker {
    public $functionName = 'worker';
}

function worker(WorkerContext $context) {
    echo '123';
}

$pool = new WorkersPool;
$pool->addWorkers('Worker', 4);
$context = new WorkerContext;
$context->valueA = 123;
$context->valueB = fopen('test.log', 'w');
$pool->dispatchWork($context);

```
