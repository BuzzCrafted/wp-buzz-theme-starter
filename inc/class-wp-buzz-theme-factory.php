<?php
/**
 * WP_Buzz_Theme_Factory Class
 *
 * Factory class for creating instances of theme components, including content data, event managers, and shortcodes.
 *
 * @package    {theme-namespace}
 * @subpackage Theme
 * @since      1.0.0
 * @version    1.0.0
 * @license    GPL-2.0-or-later
 * @link       {theme-author-uri}
 * @author     {theme-author}
 */

namespace WP_Buzz\Theme;

use WP_Buzz\Builder\WP_Buzz_Theme_Builder;
use WP_Buzz\Configurator\WP_Buzz_Theme_Content_Configurator;

use Bdev\ContentManagement\Interfaces\Content_Data_Interface;
use Bdev\Theme\Abstract_Theme_Factory;
use Bdev\EventManagement\Event_Manager;
use Bdev\Shortcodes\Shortcode_Manager;


/**
 * Class WP_Buzz_Theme_Factory
 *
 * Factory class for creating theme-related instances.
 *
 * @since 1.0.0
 */
class WP_Buzz_Theme_Factory extends Abstract_Theme_Factory {

	/**
	 * Create a new Content_Data_Interface instance.
	 *
	 * @since 1.0.0
	 *
	 * @return Content_Data_Interface The content data configurator instance.
	 */
	public function create_content_data(): Content_Data_Interface {
		$theme_builder = new WP_Buzz_Theme_Builder();
		return $theme_builder
			->set_theme_content_configurator( new WP_Buzz_Theme_Content_Configurator() )
			->build();
	}

	/**
	 * Create a new Event_Manager instance.
	 *
	 * @since 1.0.0
	 *
	 * @return Event_Manager The event manager instance.
	 */
	public function create_event_manager(): Event_Manager {
		return new Event_Manager();
	}

	/**
	 * Create a new Shortcode_Manager instance.
	 *
	 * @since 1.0.0
	 *
	 * @return Shortcode_Manager The shortcode manager instance.
	 */
	public function create_shortcode_manager(): Shortcode_Manager {
		return new Shortcode_Manager();
	}
}
