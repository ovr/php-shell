#!/usr/bin/php -dextension=shell.so -denable_dl=on
<?php
dl('shell.so');
var_dump(extension_loaded('shell'));
$stdin = fopen('php://temp', 'w');
$stdout = fopen('php://temp', 'w');
var_dump(\Shell\Subprocess::call('php', $stdin, $stdout));

fwrite($stdin, "<?php \$date = date('r');\n");
fwrite($stdin, "echo \$date;");
fwrite($stdin, "exit();");
fclose($stdin);
rewind($stdout);
fpassthru($stdout);
