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
	 * Retrieve configuration options for event subscribers.
	 *
	 * This method allows you to define event subscribers that add functionality to your theme.
	 * It returns an array that provides the event subscribers with the necessary configuration options.
	 * The array structure is:
	 *   'section' => array('option' => 'Subscriber_Interface')
	 *
	 * @since 1.0.0
	 * @return array Array of event subscriber configuration options.
	 */
	public function get_event_subscribers(): array {
		return array();
	}

	/**
	 * Retrieve configuration options for shortcodes.
	 *
	 * This method defines the WordPress shortcodes provided by your theme.
	 * It returns an array containing the necessary configuration options for each shortcode.
	 * The array structure is:
	 *   'section' => array('option' => 'Shortcode_Interface')
	 *
	 * @since 1.0.0
	 * @return array Array of shortcode configuration options.
	 */
	public function get_shortcode_config(): array {
		return array();
	}

	/**
	 * Retrieve configuration options for theme settings.
	 *
	 * Provides the configuration for the theme settings section.
	 *
	 * The array structure is:
	 *   'section' => array('option')
	 *
	 * @since 1.0.0
	 * @return array Array of theme settings options.
	 */
	public function get_theme_settings(): array {
		return array();
	}
}
