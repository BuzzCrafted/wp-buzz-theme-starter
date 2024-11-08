<?php
/**
 * Theme configurator
 *
 * Handles theme configuration.
 *
 * @package    WP_Buzz
 * @subpackage Configurator
 * @since      1.0.0
 */

namespace WP_Buzz\Configurator;

use Bdev\ContentManagement\Interfaces\Theme_Content_Configuration_Interface;
use Bdev\EventManagement\Interfaces\Subscriber_Interface;
use Bdev\Shortcodes\Interfaces\Shortcode_Interface;

/**
 * Class WP_Buzz_Theme_Content_Configurator
 *
 * This class is responsible for handling the configuration of the theme.
 * It implements the Theme_Content_Configuration_Interface to ensure that
 * all necessary configuration options for event subscribers, shortcodes,
 * and theme settings are properly defined and retrievable.
 *
 * @since 1.0.0
 */
class WP_Buzz_Theme_Content_Configurator implements Theme_Content_Configuration_Interface {
		/**
		 * Retrieve an array of event subscribers.
		 *
		 * Implementations should return all event or action subscribers
		 * associated with the theme.
		 *
		 * @since 1.0.0
		 * @return array<string, Subscriber_Interface>> Array of event subscribers.
		 */
	public function get_event_subscribers(): array {
		return array();
	}

		/**
		 * Retrieve an array of shortcode configurations.
		 *
		 * Implementations should return all shortcode configurations
		 * associated with the theme.
		 *
		 * @since 1.0.0
		 * @return array<string, array<string, Shortcode_Interface>> Array of shortcode configurations.
		 */
	public function get_shortcode_config(): array {
		return array();
	}

		/**
		 * Retrieve an array of theme settings.
		 *
		 * Implementations should return all theme settings
		 * associated with the theme.
		 *
		 * @since 1.0.0
		 * @return array<string, mixed> Array of theme settings.
		 */
	public function get_theme_settings(): array {
		return array();
	}
}
