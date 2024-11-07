<?php
/**
 * This file is part of {theme-name}.
 *
 * @package {theme-namespace}
 * @subpackage Theme
 * @since 1.0.0
 */

namespace WP_Buzz;

use WP_Buzz\Theme\WP_Buzz_Theme_Factory;

/**
 * Autoload Classes
 */
$vendor_file = plugin_dir_path( __FILE__ ) . '/vendor/autoload.php';

if ( is_readable( $vendor_file ) ) {
	include_once $vendor_file;
}

$theme = ( new WP_Buzz_Theme_Factory() )->create_content_data();

$theme->load_theme();

/**
 * Loadd extra functions
 */
$func_file = plugin_dir_path( __FILE__ ) . '/functions-addon.php';

if ( is_readable( $func_file ) ) {
	include_once $func_file;
}
