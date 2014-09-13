#!/usr/bin/php -dextension=shell.so -denable_dl=on
<?php
if (!extension_loaded('shell')) dl('shell.so');
var_dump(extension_loaded('shell'));

$process = Shell\Subprocess::popen('bc');
var_dump($process);
var_dump($process->communicate("5 + 5\n"));
$process->wait();

// fwrite($stdin, "echo \$date;");
// fwrite($stdin, "exit();");
// fclose($stdin);
