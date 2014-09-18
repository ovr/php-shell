#!/usr/bin/php
<?php
if (!extension_loaded('shell')) {
	print_r(get_loaded_extensions());
	exit(1);
} else {
	exit(0);
}
