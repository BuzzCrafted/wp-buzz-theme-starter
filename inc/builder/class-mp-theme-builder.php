<?php

use Bdev\ContentManagement\Interfaces\Theme_Content_Configuration_Interface;
use Bdev\ContentManagement\Theme_Content_Provider;
use Bdev\ContentManagement\Theme_Content_Provider_Builder_Interface;

class MP_Theme_Builder implements Theme_Content_Provider_Builder_Interface {

	/**
	 * Theme configurator.
	 *
	 * Stores the configuration required for building theme content.
	 *
	 * @since 1.0.0
	 * @var Theme_Content_Configuration_Interface
	 */
	private Theme_Content_Configuration_Interface $theme_configurator;

	/**
	 * Set the theme content configurator.
	 *
	 * Configures the builder with a specific theme content configurator, which provides the necessary configuration details for building theme content.
	 *
	 * @since 1.0.0
	 *
	 * @param Theme_Content_Configuration_Interface $configurator The content configurator instance.
	 * @return Theme_Content_Provider_Builder_Interface The instance of the builder.
	 */
	public function set_theme_content_configurator( Theme_Content_Configuration_Interface $configurator ): self {
		$this->theme_configurator = $configurator;
		return $this;
	}

	/**
	 * Builds and returns an instance of Theme_Content_Provider.
	 *
	 * Uses the theme content configurator to build and provide a Theme_Content_Provider instance, which manages theme event subscribers, shortcodes, and settings.
	 *
	 * @since 1.0.0
	 *
	 * @return Theme_Content_Provider The built Theme_Content_Provider instance.
	 */
	public function build(): Theme_Content_Provider {
		return new Theme_Content_Provider(
			$this->theme_configurator->get_event_subscribers(),
			$this->theme_configurator->get_shortcode_config(),
			$this->theme_configurator->get_theme_settings()
		);
	}
}
