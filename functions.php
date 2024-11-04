<?php
/**
 * This file is part of {theme-name}.
 *
 * @package {theme-namespace}
 * @subpackage Theme
 * @since 1.0.0
 */

namespace {theme-namespace};

/**
 * Autoload Classes
 */
$vendor_file = plugin_dir_path( __FILE__ ) . '/vendor/autoload.php';

if ( is_readable( $vendor_file ) ) {
	include_once $vendor_file;
}

$theme = new {theme-namespace}_Theme();

/**
 * Loadd extra functions
 */
$func_file = plugin_dir_path( __FILE__ ) . '/functions-addon.php';

if ( is_readable( $func_file ) ) {
	include_once $func_file;
}
