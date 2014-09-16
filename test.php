#!/usr/bin/php -dextension=shell.so -denable_dl=on
<?php
use \Shell\Workers\WorkersPool;
use \Shell\Workers\WorkerContext;
if (!extension_loaded('shell')) dl('shell.so');
var_dump(extension_loaded('shell'));

$pool = new WorkersPool;
$pool->addWorkers('Worker', 1);
var_dump($pool->getCountWorkers(),
	$pool->getCountFreeWorkers());
// $context = new WorkerContext;
// $context->asb = '124';
//var_dump($pool->dispatchWork($context));
var_dump($pool->delWorkers(2));
var_dump($pool->getCountWorkers(),
	$pool->getCountFreeWorkers());

class Worker extends \Shell\Workers\Worker {
	public $functionName = 'worker';
}

// $w = new \Shell\Workers\Worker;
// var_dump($w);

function worker(WorkerContext $context) {
	var_dump($context);
	echo 'I am a worker'.PHP_EOL;
}
