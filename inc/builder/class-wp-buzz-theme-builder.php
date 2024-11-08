<?php
/**
 * Class WP_Buzz_Theme_Builder
 *
 * This class implements the Theme_Content_Provider_Builder_Interface to build
 * concrete classes for the WordPress theme {theme-name} implementation.
 *
 * @author     {theme-author}
 * @since      1.0.0
 * @version    1.0.0
 * @package    WP_Buzz
 * @subpackage Builder
 */

namespace WP_Buzz\Builder;

use Bdev\ContentManagement\Interfaces\Theme_Content_Configuration_Interface;
use Bdev\ContentManagement\Theme_Content_Provider;
use Bdev\ContentManagement\Interfaces\Theme_Content_Provider_Builder_Interface;

/**
 * WP_Buzz_Theme_Builder constructor.
 *
 * Initializes the builder with the necessary configurator.
 *
 * @since 1.0.0
 */
class WP_Buzz_Theme_Builder implements Theme_Content_Provider_Builder_Interface {

	/**
	 * Theme configurator.
	 *
	 * Stores the configuration required for building*
	 *
	 * @since 1.0.0
	 * @var Theme_Content_Configuration_Interface
	 */
	private Theme_Content_Configuration_Interface $theme_configurator;

	/**
	 * Set thefigurator.
	 *
	 * Configures the builder with a specificfigurator, which provides the necessary configuration details for building*
	 *
	 * @since 1.0.0
	 *
	 * @param Theme_Content_Configuration_Interface $configurator The content configurator instance.
	 * @return CoolPresser_Theme_Builder The instance of the builder.
	 */
	public function set_theme_content_configurator( Theme_Content_Configuration_Interface $configurator ): self {
		$this->theme_configurator = $configurator;
		return $this;
	}

	/**
	 * Builds and returns an instance of Theme_Content_Provider.
	 *
	 * Uses thefigurator to build and provide a Theme_Content_Provider instance, which managesribers, shortcodes, and settings.
	 *
	 * @since 1.0.0
	 *
	 * @return Theme_Content_Provider The built Theme_Content_Provider instance.
	 */
	public function build(): Theme_Content_Provider {
		return new Theme_Content_Provider(
			$this->theme_configurator->get_event_subscribers(),
			$this->theme_configurator->get_shortcode_config()
		);
	}
}
