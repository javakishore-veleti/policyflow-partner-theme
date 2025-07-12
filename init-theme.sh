#!/bin/bash

set -e

THEME_NAME="partner_theme"
THEME_TITLE="PolicyFlow Partner Theme"

echo "Initializing Drupal theme: $THEME_TITLE"

# Create directories
mkdir -p css js templates

# Create .info.yml
cat <<EOL > ${THEME_NAME}.info.yml
name: '$THEME_TITLE'
type: theme
description: 'A custom Drupal theme for PolicyFlow partner portal.'
core_version_requirement: ^10
package: Custom
base theme: classy
libraries:
  - ${THEME_NAME}/global-styling
regions:
  header: 'Header'
  primary_menu: 'Primary Menu'
  content: 'Content'
  sidebar_first: 'Sidebar First'
  footer: 'Footer'
EOL

# Create .libraries.yml
cat <<EOL > ${THEME_NAME}.libraries.yml
global-styling:
  version: 1.x
  css:
    theme:
      css/style.css: {}
  js:
    js/script.js: {}
  dependencies:
    - core/jquery
EOL

# Create .theme PHP file
cat <<EOL > ${THEME_NAME}.theme
<?php

/**
 * @file
 * Theme hooks and preprocess functions for the $THEME_TITLE.
 */
EOL

# Create CSS
cat <<EOL > css/style.css
body {
  background-color: #f9f9f9;
  font-family: Arial, sans-serif;
}
EOL

# Create JS
cat <<EOL > js/script.js
(function ($, Drupal) {
  Drupal.behaviors.${THEME_NAME} = {
    attach: function (context, settings) {
      console.log("Custom theme JS loaded.");
    }
  };
})(jQuery, Drupal);
EOL

# Create Twig template
cat <<EOL > templates/page.html.twig
<!DOCTYPE html>
<html>
  <head>
    <head-placeholder token="{{ placeholder_token }}">
    <title>{{ head_title }}</title>
    <css-placeholder token="{{ placeholder_token }}">
    <js-placeholder token="{{ placeholder_token }}">
  </head>
  <body>
    <header role="banner">
      {{ page.header }}
    </header>
    <main role="main">
      {{ page.content }}
    </main>
    <footer role="contentinfo">
      {{ page.footer }}
    </footer>
  </body>
</html>
EOL

# Create composer.json
cat <<EOL > composer.json
{
  "name": "policyflow/partner-theme",
  "description": "Drupal theme for PolicyFlow partner portal",
  "type": "drupal-theme",
  "license": "Apache-2.0",
  "minimum-stability": "stable",
  "prefer-stable": true
}
EOL

echo "✅ Theme structure initialized successfully!"
